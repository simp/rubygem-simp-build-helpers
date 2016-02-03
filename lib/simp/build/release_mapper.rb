require 'yaml'


module Simp::Build
  class SIMPBuildException < Exception; end
  class ReleaseMapper
    def initialize( target_release, mappings_file )
      @target_release = target_release
      @mappings_file = mappings_file
      @release_mappings = YAML.load_file( mappings_file )
      @target_data = get_release_mappings_for_target( @target_release, @release_mappings )
    end


    def validate_iso_paths( iso_paths )
      source_flavor = nil

      binding.pry
      # Validate ISOs
      iso_paths.split(':').each do |iso_path|
        if File.file? iso_path
          source_flavor = get_rel_flavor_for_iso iso_path

          binding.pry
        elsif File.directory? iso_path
          binding.pry
        else
           raise SIMPBuildException, "No file or directory at Source ISO path '#{iso_path}'"
        end
      end
      binding.pry
    end

    def get_release_mappings_for_target( target_release, release_mappings )
      unless target_data = release_mappings
                             .fetch('simp_releases')
                             .fetch( target_release, false )

         raise SIMPBuildException, "'#{target_release}' is not a recognized SIMP release." +
                                   "\n\n## Recognized SIMP releases:\n" +
                                   release_mappings.fetch('simp_releases')
                                      .keys
                                      .map{|x| "  - #{x}\n"}
                                      .join +
                                   "\n\n"
      end
      target_data
    end


    def get_rel_flavor_for_iso_by_name( iso_path, target_data )
      name = File.basename iso_path
      source_flavors = target_data['flavors']
                                 .select do |flavor,flavor_data|
                                   !flavor_data['isos']
                                     .select{|iso| iso['name'] == name}
                                       .empty?
                                 end
                                   .keys

      unless source_flavors.size <= 1
         raise SIMPBuildException, "Multiple Source Flavors (#{source_flavors.size}) detected!" +
                                   "\n\n" +
                                   source_flavors.map{|x| "  - #{x}\n"}.join +
                                   "\n\n" +
                                   "were found when looking up name '#{name}'." +
                                   "Check the release_mappings for bad data.\n"
      end
      source_flavors.join
    end

    def get_rel_flavor_for_iso_by_size( iso_path )
      size = File.size iso_path
      source_flavors = @target_data['flavors']
                         .select do |flavor,flavor_data|
                           !flavor_data['isos']
                             .select{|iso| iso['size'] == size}
                               .empty?
                         end
                           .keys

      if source_flavors.size > 1
         name_flavors   = get_rel_flavor_for_iso_by_name(iso_path)
         source_flavors = source_flavors & name_flavors
      end

      unless source_flavors.size <= 1
         raise SIMPBuildException, "Multiple Source Flavors detected (#{source_flavors.size})!" +
                                   "\n\n" +
                                   source_flavors.map{|x| "  - #{x}\n"}.join +
                                   "\n\n" +
                                   "were found when looking up size '#{size}'." +
                                   "Check the release_mappings for bad data.\n"
      end
      source_flavors.join
    end

    # returns a list of all release flavors (e.g., 'CentOS', 'RedHat')
    def get_rel_flavor_for_iso( iso_path )
      name = File.basename iso_path
      size = File.size iso_path
      size_flavor = get_rel_flavor_for_iso_by_size( iso_path )
    binding.pry
      if !size_flavor.empty?
        flavor_isos = @target_data['flavors'][size_flavor]['isos']
        name_map = Hash[flavor_isos.map{|x| [x['name'],x['size']]}]
        ##if name_map[name] != size
        ##  warn
    binding.pry
      end
      size_flavor
    end
  end
end
