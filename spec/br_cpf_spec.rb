require 'spec_helper'


class DummyWithBrCPF < ValidationsTest
  attr_accessor :cpf
  validates :cpf, br_cpf: true
end

describe ActiveModel::Validations::BrCpfValidator, 'validates with' do


  it "valid brazilian cpfs" do
    DummyWithBrCPF.new(cpf: nil).valid?.should be_true
    DummyWithBrCPF.new(cpf: '').valid?.should be_true
    DummyWithBrCPF.new(cpf: ' ').valid?.should be_true
    DummyWithBrCPF.new(cpf: '22756644242').valid?.should be_true
    DummyWithBrCPF.new(cpf: '227.566.442-42').valid?.should be_true
  end


  it "invalid brazilian cpfs" do
    DummyWithBrCPF.new(cpf: '1234').valid?.should be_false
    DummyWithBrCPF.new(cpf: '11111111111111111').valid?.should be_false
    DummyWithBrCPF.new(cpf: '1.2.3.4.1').valid?.should be_false
    DummyWithBrCPF.new(cpf: 'word').valid?.should be_false
    DummyWithBrCPF.new(cpf: '36192118299').valid?.should be_false
    DummyWithBrCPF.new(cpf: '227.566.44242').valid?.should be_false
    DummyWithBrCPF.new(cpf: '227566.442-42').valid?.should be_false
    DummyWithBrCPF.new(cpf: '227566442-42').valid?.should be_false
    DummyWithBrCPF.new(cpf: '00000000000').valid?.should be_false
  end


end