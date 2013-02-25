require 'spec_helper'


class DummyWithBrCNPJ < ValidationsTest
  attr_accessor :cnpj
  validates :cnpj, br_cnpj: true
end

describe ActiveModel::Validations::BrCnpjValidator, 'validates with' do


  it "valid brazilian cnpjs" do
    DummyWithBrCNPJ.new(cnpj: nil).valid?.should be_true
    DummyWithBrCNPJ.new(cnpj: '').valid?.should be_true
    DummyWithBrCNPJ.new(cnpj: ' ').valid?.should be_true
    DummyWithBrCNPJ.new(cnpj: '28261861000142').valid?.should be_true
    DummyWithBrCNPJ.new(cnpj: '28.261.861/0001-42').valid?.should be_true
  end


  it "invalid brazilian cnpjs" do
    DummyWithBrCNPJ.new(cnpj: '1234').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '00000000000000').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '1.2.3.4.1').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: 'word').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '22756644242').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '227.566.442-42').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '28.261.861/000142').valid?.should be_false
    DummyWithBrCNPJ.new(cnpj: '28261861/0001-42').valid?.should be_false
  end


end