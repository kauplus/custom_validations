require 'spec_helper'


class DummyWithURL < ValidationsTest
  attr_accessor :url
  validates_url_of :url
end

class DummyURLAsHost < ValidationsTest
  attr_accessor :url
  validates_url_of :url, as_host: true
end


describe ActiveModel::Validations::UrlValidator, 'validates with' do


  it "valid urls" do
    DummyWithURL.new(url: nil).valid?.should be_true
    DummyWithURL.new(url: '').valid?.should be_true
    DummyWithURL.new(url: ' ').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/').valid?.should be_true
    DummyWithURL.new(url: 'https://www.kauplus.com/').valid?.should be_true
    DummyWithURL.new(url: ' http://www.kauplus.com/').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/ ').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/planos').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/planos?').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/planos?arg1=true').valid?.should be_true
    DummyWithURL.new(url: 'http://www.kauplus.com/assets/kauplus-logo.png').valid?.should be_true
    DummyWithURL.new(url: 'http://kauplus/').valid?.should be_true
    DummyWithURL.new(url: 'http://kauplus').valid?.should be_true
  end


  it "valid urls as host" do
    DummyURLAsHost.new(url: nil).valid?.should be_true
    DummyURLAsHost.new(url: '').valid?.should be_true
    DummyURLAsHost.new(url: ' ').valid?.should be_true
    DummyURLAsHost.new(url: 'www.kauplus.com').valid?.should be_true
    DummyURLAsHost.new(url: 'kauplus.com').valid?.should be_true
  end


  it "invalid urls" do
    DummyWithURL.new(url: 'http://.com/').valid?.should be_false
    DummyWithURL.new(url: 'asdfasdf http://invalid.no?crap=this-is-invalid').valid?.should be_false
    DummyWithURL.new(url: 'example@kauplus.com').valid?.should be_false
    DummyWithURL.new(url: 'mailto:example@kauplus.com').valid?.should be_false
    DummyWithURL.new(url: 'http://').valid?.should be_false
  end


    it "invalid urls as host" do
    DummyURLAsHost.new(url: 'http://www.kauplus.com/').valid?.should be_false
    DummyURLAsHost.new(url: 'www.kauplus.com/').valid?.should be_false
    DummyURLAsHost.new(url: 'www.kauplus.com:80').valid?.should be_false
    DummyURLAsHost.new(url: 'www.kauplus.com?query=1').valid?.should be_false
    DummyURLAsHost.new(url: '.com').valid?.should be_false
  end


end