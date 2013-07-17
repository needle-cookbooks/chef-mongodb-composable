require 'chefspec'

describe 'mongodb::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'mongodb::default' }
  it 'should do nothing' do
    pending '.'
  end
end
