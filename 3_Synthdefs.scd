"1_Load_AudioFiles.scd".loadRelative;


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


SynthDef(\effect2, {|in, out,lowFreq=200, hiFreq = 400|
	var sig, vib;
	sig = In.ar(in, 2);
	vib = BPF.kr(in, MouseX.kr(1, 100, 1), 0.3) * 10;
	sig = sig * SinOsc.ar(vib * 5 + 10) * 0.2;
	Out.ar(out, sig);
}).add;

SynthDef(\effec3, { |in, out, lowFreq=100, hiFreq = 200 ,amp = 0.1|
	var sig, ctl;
	sig = In.ar(in, 2);
	ctl = HPF.kr(in, MouseX.kr(2, 200, 1));
	sig = sig * SinOsc.ar(ctl * 5 + 10) * 0.1;
    Out.ar(out, sig);
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

