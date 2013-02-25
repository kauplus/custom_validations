require 'spec_helper'


class DummyWithEmail < ValidationsTest
  attr_accessor :email
  validates_email_of :email
end

def email_valid?(email)
  DummyWithEmail.new(email: email).valid?
end


describe ActiveModel::Validations::EmailValidator, 'validates with' do


  it "valid emails" do
    email_valid?(nil).should be_true
    email_valid?('').should be_true
    email_valid?(' ').should be_true
    email_valid?('example@kauplus.com.br').should be_true
    email_valid?('example@123.com').should be_true
  end


  it "invalid emails" do
    email_valid?('example').should be_false
    email_valid?('example@kauplus.com.').should be_false
    email_valid?('example@kauplus@kauplus.com.br').should be_false
    email_valid?('example@kauplus').should be_false
    email_valid?('@').should be_false
    email_valid?('kauplus.com').should be_false
    email_valid?('example@kauplus .com.br').should be_false
    email_valid?(' example@kauplus.com.br').should be_false
    email_valid?('example@kauplus.com.br ').should be_false
    email_valid?(' example@kauplus.com.br ').should be_false
  end


end