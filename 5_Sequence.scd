
"OSC_Qualisis.scd".loadRelative;
"Load_AudioFiles.scd".loadRelative;
"SoundSettings.scd".loadRelative;

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


(


var sequence = Pseq([
	{"Start!".postln;},
	{x = ~loops[0].play},
	{x.stop; x = ~creep1.play},
	{x.stop; ~loops[1].play},
	{~creep2.play},
	{~loops[2].play},
	{~creep3.play},
	{~loops[3].play},
	{~creep4.play},
	{"End!".postln;}
]);

var stream = sequence.asStream;

var nextFunction = {
	"Go!".postln;
	stream.next.value;
};

var window = Window("Colors", 300@300);
var button = Button(window, 300@300);
button.string = "Go!";
button.action = {nextFunction.value;};

window.front;
)
