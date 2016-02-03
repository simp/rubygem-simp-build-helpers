require 'spec_helper'
require 'simp/build/release_mapper'

describe Simp::Build::ReleaseMapper do
  let :mapper do
    mappings_path = File.expand_path( 'files/release_mappings.yaml', File.dirname(__FILE__) )
    Simp::Build::ReleaseMapper.new( '5.1.X', mappings_path )
  end

  it "#initialize" do
    mapper
  end
end

