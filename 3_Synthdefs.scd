"1_Load_AudioFiles.scd".loadRelative;


(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;


SynthDef(\effect1, {|in, out, freq = 400|
	var source = In.ar(in, 2);
	var line = Line.kr(0, 1, 60);
	var fx = source * SinOsc.ar(freq, MouseY.kr(0, 2pi), MouseX.kr(0, 1));
	Out.ar(out, (source * (1.0-line)) + (fx * line));
}).add;


SynthDef(\effect2, {|in, out, wet|
	var drySignal, wetSignal, vib;
	drySignal = In.ar(in, 2);
	vib = BPF.kr(in, MouseX.kr(1, 100, 1), 0.3) * 10;
	wetSignal = drySignal * SinOsc.ar(vib * 5 + 10) * 0.2;
	Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;

SynthDef(\effect3, { |in, out,wet|
	var drySignal, wetSignal, ctl;
	drySignal = In.ar(in, 2);
	ctl = HPF.kr(in, MouseX.kr(2, 200, 1));
	wetSignal = drySignal * SinOsc.ar(ctl * 5 + 10) * 0.1;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
);


/*

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
*/

