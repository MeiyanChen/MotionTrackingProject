(
"1_Load_AudioFiles.scd".loadRelative;
"3_Synthdefs.scd".loadRelative;
//"4_OSC_Qualisis.scd".loadRelative;
)

(

// master score
Tdef(\loopSequence, {

	f = Bus.audio(s, 2);

	~effect = Synth(\effect1, [\in, f]); //

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_1".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[0], \out, f]);
		(6*4*0.5).wait;
	});

	// ~effect.free;
	// ~effect = Synth(\effect2, [\in, f]);

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_2".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[1], \out, f]);
		(6*4*0.5).wait;
	});


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop1_3".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[2], \out, f]);
		(6*4*0.5).wait;
	});

   ~keepLooping = true;
		{~keepLooping}.while ({
		"loop2".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[3], \out, f]);
		(9*4*0.5).wait;
	});

	// ~effect.free;
	// ~effect = Synth(\effect2, [\in, f]);

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop3_1".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[4], \out, f]);
		(10*4*0.5).wait;
	});


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop3_2".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[5], \out, f]);
		(9*4*0.5).wait;
	});

	~keepLooping = true;
		{~keepLooping}.while ({
		"loop3_3".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[6], \out, f]);
		(9.5*4*0.5).wait;
	});

	// ~effect.free;
	// ~effect = Synth(\effect2, [\in, f]);

	~keepLooping = true;
	{~keepLooping}.while ({
		"loop4".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[7], \out, f]);
		(9*4*0.5).wait;
	});


	~keepLooping = true;
	{~keepLooping}.while ({
		"loop5".postln;
		Synth(\bufferPlayer, [\buffer, ~loops[8], \out, f]);
		(8*4*0.5).wait;
	});

	"end".postln;

});
)

Tdef(\loopSequence).play;

~keepLooping = false;//change stem


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
*/
