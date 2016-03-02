require "person"

RSpec.describe Person do

  it "has a person" do
    p = Person.new
    expect(p.name).to eq("Juan")
  end
  
end