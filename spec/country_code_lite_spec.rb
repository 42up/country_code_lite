RSpec.describe CountryCodeLite do
  it "has a version number" do
    expect(CountryCodeLite::VERSION).not_to be nil
  end

  it "#find_by_name" do
    entry = CountryCodeLite.find_by_name("中国")

    expect(entry.name).to eq("中国")
    expect(entry.code).to eq("CN")
    expect(entry.number).to eq(86)
  end

  it "#find_by_code" do
    entry = CountryCodeLite.find_by_code("HK")

    expect(entry.name).to eq("香港")
    expect(entry.code).to eq("HK")
    expect(entry.number).to eq(852)
  end

  it "#find_by_number" do
    entry = CountryCodeLite.find_by_number(852)

    expect(entry.name).to eq("香港")
    expect(entry.code).to eq("HK")
    expect(entry.number).to eq(852)
  end

  it "#to_number" do
    phone = "1332221111"
    code = 852

    number = CountryCodeLite.to_number(phone, code)
    expect(number).to eq("+#{code}#{phone}")

    number = CountryCodeLite.to_number(phone, code, false)
    expect(number).to eq("#{code}#{phone}")
  end
end
