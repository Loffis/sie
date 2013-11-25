require "spec_helper"
require "sie/parser/line_parser"

describe Sie::Parser::LineParser, "parse" do
  it "parses lines from a sie file" do
    parser = Sie::Parser::LineParser.new('#TRANS 2400 {} -200 20130101 "Foocorp expense"')
    entry = parser.parse
    expect(entry.label).to eq("trans")
    expect(entry.attributes).to eq({
      "kontonr" => "2400",
      "belopp"  => "-200",
      "transdat" => "20130101",
      "transtext" => "Foocorp expense"
    })
  end

  it "fails if you have non empty metadata arrays until there is a need to support that" do
    parser = Sie::Parser::LineParser.new('#TRANS 2400 { 1 "2" } -200 20130101 "Foocorp expense"')
    expect(-> { parser.parse }).to raise_error(/don't support metadata/)
  end
end
