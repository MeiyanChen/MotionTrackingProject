"1_Load_AudioFiles.scd".loadRelative;


(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;

SynthDef(\effect1, {|in, out, freq = 400, endvalue = 20|
	var source = In.ar(in, 2);
	var line = Line.kr(0, 1, endvalue);
	var fx = source * SinOsc.ar(freq, MouseY.kr(0, 2pi), MouseX.kr(0, 1));
	Out.ar(out, (source * (1.0-line)) + (fx * line));
}).add;


SynthDef(\effect2, {|in, out, wet = 0.9|
	var drySignal, wetSignal, vib;
	drySignal = In.ar(in, 2);
	vib = BPF.ar(drySignal, MouseX.kr(20, 400, 1), 0.3) * 2;
	wetSignal = drySignal * SinOsc.ar(vib * 5 + 10) * 0.2;
	Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;



SynthDef(\effect3, { |in, out,wet = 0.9|
	var drySignal, wetSignal, ctl;
	drySignal = In.ar(in, 2);
	ctl = HPF.ar(drySignal, MouseX.kr(20, 60, 1));
	wetSignal = drySignal * ctl;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;

SynthDef(\effect4, {|in, out|
    Out.ar(
        out,
        DelayN.ar(
            In.ar(in, 2),
			MouseX.kr(0.0, 0.5),
            MouseY.kr(0.0, 0.5)
        )
    )
}).add;

SynthDef(\effect5, { |in, out, wet = 0.9, size = 3|
	var drySignal, wetSignal, rev;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,1, MouseX.kr(0.0, 1.0), MouseX.kr(0.5, 4.0));
	wetSignal = drySignal * rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

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

