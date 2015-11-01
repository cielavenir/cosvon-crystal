#coding:utf-8
SPEC_DIR=File.expand_path(File.dirname(__FILE__))
require "./spec_helper"

cases=[
	{
		{
			"DreamCast"=>"SEGA",
			"HI-Saturn"=>"Hitachi",
			"FamiconTV"=>"Sharp",
		},<<-EOM
CoSVON:0.1
DreamCast,SEGA
HI-Saturn,Hitachi
FamiconTV,Sharp
EOM
	},{
		{
			"foo"=>"bar",
		},<<-EOM
CoSVON:0.1
foo,bar
EOM
	},{
		{
			"comma"=>"[,]",
			"dq"=>"[\"]",
			"n"=>"[\n]",
			"tab"=>"[\t]",
		},<<-EOM
CoSVON:0.1
comma,"[,]"
dq,"[""]"
n,"[
]"
tab,[	]
EOM
	},{
		{
			"SH3"=>"Super Hitachi 3",
			"ATOK"=>"Awa TOKushima",
			"ICU" => "Isolated Crazy Utopia",
			"BING"=>"Bing Is Not Google",
		},<<-EOM
CoSVON:0.1
SH3,Super Hitachi 3
ATOK,Awa TOKushima
ICU,Isolated Crazy Utopia
BING,Bing Is Not Google
EOM
	},{
		{
			"Google"=>"Chrome",
			"Apple"=>"Safari",
			"Opera"=>"Opera",
			"Mozilla"=>"Firefox"
		},<<-EOM
CoSVON:0.1,,,
Google,Chrome,,
Apple,Safari,"",
Opera,Opera,,""
Mozilla,Firefox,"",""
,,,
,,,
,,,
EOM
	},{
		{
			"no DQ"=>"foo",
			"with DQ"=>"foo",
			"inner DQ"=>"foo\"bar",
			"many DQs"=>"\"\"\"\"\"\"\"\"\""
		},<<-EOM
CoSVON:0.1
no DQ,foo
with DQ,"foo"
inner DQ,"foo""bar"
many DQs,""""""""""""""""""""
EOM
	},{
		{
			"no extra comma"=>"hoge",
			"extra comma"=>"fuga",
			"extra comma with DQ"=>"piyo",
			"many extra commas"=>"moge"
		},<<-EOM
CoSVON:0.1
no extra comma,hoge
extra comma,fuga,
extra comma with DQ,piyo,""
many extra commas,moge,,,,,,,
"",""
,,
,"",
EOM
	}
]

describe "CoSVON [default]" do
	cases.each_with_index{|e,i|
		it "Case #{i+1}" do
			hash=CoSVON.parse(e[1])
			hash.should_not be_a Nil
			if hash.is_a?(Hash)
				cosvon=CoSVON.stringify(hash)
				CoSVON.parse(cosvon).should eq e[0]
			end
		end
	}
end

describe "CoSVON.csv" do
	it "Parsing dame backslash" do
		s=File.read(SPEC_DIR+"/hsalskcab_utf8.csv")#.encode("UTF-8")
		CoSVON.csv(s).should eq [["Hello \"World\"","我申\"May you have good luck.\""]]
	end
end
