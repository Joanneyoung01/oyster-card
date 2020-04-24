require 'station'

describe Station do

  subject {described_class.new(name: "Balham", zone: 3)}

  it "knows what the name of station it is" do
    expect(subject.name).to eq "Balham"
  end

  it "knows what zone it is" do
    expect(subject.zone).to eq 3
  end
end