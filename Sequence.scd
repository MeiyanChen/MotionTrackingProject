//load the audio file

(
~material1 = Array.new;
~folder1 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/Material1Ochestra/Bounces/");


~folder1.entries.do({
	arg path;
	~material1 = ~material1.add(Buffer.read(s, path.fullPath));
});




~material2 = Array.new;
~folder2 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/PencilSound/");


~folder2.entries.do({
	arg path;
	~material2 = ~material2.add(Buffer.read(s, path.fullPath));
});
)


( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

c.set(0.5);

( // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.play;
)


//play it raw
~material1[0].play;
~material1[1].play;
~material1[2].play;
~material1[3].play;
~material1[4].play;
~material1[5].play;
~material1[6].play;
~material1[7].play;

~material2[0].play;
~material2[1].play;


/*
var sequence = Pseq([
	"Part A",
	"Part B",
	"Part C",
	"Part D"
]);

var stream = sequence.asStream;

var nextFunction = {
	"Go!".postln;
	stream.next.postln;
};
*/

// we can only use number in Pseq?

~function1 = {"A function outside of the scope stored in an envirnmental variable".postln; 40 + 40;};
(

var multiLineFunction = {
	"This is a test for multi line function".postln;
	100 + 100;
	Synth(\buffer1);
};

var sequence = Pseq([
	{"Start!".postln;},
	{x = ~material[1].play},
	{x.stop; ~effect1.play},
	~function1,
	multiLineFunction,
	{"End!".postln;}
]);

var stream = sequence.asStream;

var nextFunction = {
	"Go!".postln;
	// Synth(\mei, [\freq, stream.next]);
	stream.next.value;
};

var window = Window("Colors", 300@300);
var button = Button(window, 300@300);
button.string = "Go!";
button.action = {nextFunction.value;};

window.front;
)