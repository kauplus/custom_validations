require 'spec_helper'


class DummyWithBrPostalCode < ValidationsTest
  attr_accessor :postal_code
  validates :postal_code, br_postal_code: true
end

describe ActiveModel::Validations::BrPostalCodeValidator, 'validates with' do


  it "valid brazilian postal codes" do
    DummyWithBrPostalCode.new(postal_code: nil).valid?.should be_true
    DummyWithBrPostalCode.new(postal_code: '').valid?.should be_true
    DummyWithBrPostalCode.new(postal_code: ' ').valid?.should be_true
    DummyWithBrPostalCode.new(postal_code: '05012-101').valid?.should be_true
    DummyWithBrPostalCode.new(postal_code: '12345678').valid?.should be_true
  end


  it "invalid brazilian postal codes" do
    DummyWithBrPostalCode.new(postal_code: '1234567').valid?.should be_false
    DummyWithBrPostalCode.new(postal_code: '050-12101').valid?.should be_false
    DummyWithBrPostalCode.new(postal_code: 'word').valid?.should be_false
    DummyWithBrPostalCode.new(postal_code: '-').valid?.should be_false
    DummyWithBrPostalCode.new(postal_code: '1234').valid?.should be_false
    DummyWithBrPostalCode.new(postal_code: '111111111111111').valid?.should be_false
  end


end