require 'spec_helper'
require 'SendGrid/Mail'
require 'time'

describe SendGrid::Mail do

  before(:each) do
     @sg = SendGrid::Mail.new
  end

  it 'takes a params hash' do
    @sg = SendGrid::Mail.new({})
  end

  it 'should take at least 1 email' do
    @sg.add_to("me@rbin.co")
    @sg.to == ["me@rbin.co"]
  end

  it 'should accept an array of emails' do
    @sg.add_to(['me@rbin.co', 'eddie@taco.computer', 'pizza@rbin.codes'])
    @sg.to[1][:email].should == "eddie@taco.computer"
  end

  it 'should accept a name' do
    @sg.add_to("bob@jon.es", "Bob Jones")
    @sg.to[0].should == {email: "bob@jon.es", name: "Bob Jones"}
  end

  it 'should match emails and names' do
    @sg.add_to(["finn@adventuretime.com", "jake@adventuretime.com", "iceking@adventuretime.com"], ["Finn", "Jake", "Ice King"])
    @sg.to[1][:name].should == "Jake"
  end

  it 'should take a from address' do
    @sg.set_from 'tacos@eddie.com'
    @sg.from.should == 'tacos@eddie.com'
  end

  it 'should take a from name' do
    @sg.set_from_name 'Rbin'
    @sg.from_name.should == 'Rbin'
  end

  it 'should take a subject' do
    @sg.set_subject "Where the cat should live"
    @sg.subject.should == "Where the cat should live"
  end

  it 'should take text' do
    @sg.set_text "No size limits lol, <code>Pizza</code> <h1>HA!</h1>"
    @sg.text.should_not == "wat"
  end

  it 'should take html' do
    @sg.set_html "<h1>This is some html.</h1><p><em>Yup.</em></p>"
    @sg.html.should_not == "lol"
  end

  it 'should allow just 1 bcc' do
    @sg.add_bcc("me@rbin.co")
    @sg.bcc[0].should == "me@rbin.co"
  end

  it 'should allow for multiple BCCs' do
    @sg.add_bcc(["me@rbin.co", "me@rbin.codes", "poptarts@eddiezane.org"])
    @sg.bcc[1].should == "me@rbin.codes"
  end

  it 'should allow for a reply to email' do
    @sg.set_reply_to "nick@loonsareamazing.com"
    @sg.reply_to.should == "nick@loonsareamazing.com"
  end

  it 'should take an rfc 2822 date' do
    @sg.set_date "Fri, 27 Jun 2014 02:54:37 -0600"
    Time.parse(@sg.date).rfc2822.should == "Fri, 27 Jun 2014 02:54:37 -0600"
  end

end