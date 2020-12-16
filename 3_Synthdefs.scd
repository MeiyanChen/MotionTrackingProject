"1_Load_AudioFiles.scd".loadRelative;

(
(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;


SynthDef(\effect1, {|in, out, freq = 400|
	var sig = In.ar(in, 2);
	var line = Line.kr(0, 1, 60);
	var fx = sig * SinOsc.ar(freq, MouseY.kr(0, 2pi), MouseX.kr(0, 1));
	Out.ar(out, (sig * (1.0-line)) + (fx * line));
}).add;


SynthDef(\effect2, {|in, out|
	var sig = In.ar(in, 2);
	sig = sig * SinOsc.ar(MouseY.kr(200, 700), 0, MouseX.kr(0, 1));
	Out.ar(out, sig);
}).add;

);



(
f = Bus.audio(s, 2);
Synth(\effect2, [\in, f]);
~which = 0;
);
)

(
Pbind(
	\instrument, \bufferPlayer,
	\buffer, Pindex([\Loops].bufnum, Pfunc({~which}), inf),
	\out, f,
	\dur, 12,
).play;
)

(

// master score
Tdef(\loopSequence, {

	f = Bus.audio(s, 2);

	~effect = Synth(\effect1, [\in, f]);

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