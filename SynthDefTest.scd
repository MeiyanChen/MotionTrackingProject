"1_Load_AudioFiles.scd".loadRelative;


(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;
)

(
SynthDef(\effect1, {|in, out, freq = 400, endvalue = 20|
	var source = In.ar(in, 2);
	var line = Line.kr(0, 1, endvalue);
	var fx = source * SinOsc.ar(freq, MouseY.kr(0, 2pi), MouseX.kr(0, 1));
	Out.ar(out, (source * (1.0-line)) + (fx * line));
}).add;

)


f = Bus.audio(s, 2);
~effect1 = Synth(\effect1, [\in, f]);
Synth(\bufferPlayer, [\buffer, ~loops[0], \endvalue, 10, \out, f]); // endvalue lower, effect more.


(
SynthDef(\effect2, {|in, out, wet|
	var drySignal, wetSignal, vib;
	drySignal = In.ar(in, 2);
	vib = BPF.kr(in, MouseX.kr(1, 400, 1), 0.3) * 10;
	wetSignal = drySignal * SinOsc.ar(vib * 5 + 10) * 0.2;
	Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;

)
g = Bus.audio(s, 2);
~effect2 = Synth(\effect2, [\in, g]);
Synth(\bufferPlayer, [\buffer, ~loops[0], \out, g]);


(
SynthDef(\effect3, { |in, out,wet|
	var drySignal, wetSignal, ctl;
	drySignal = In.ar(in, 2);
	ctl = HPF.kr(in, MouseX.kr(2, 200, 1));
	wetSignal = drySignal * SinOsc.ar(ctl * 5 + 10) * 0.1;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

h = Bus.audio(s, 2);
~effect3 = Synth(\effect3, [\in, h]);
Synth(\bufferPlayer, [\buffer, ~loops[0], \out, h]);


(
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
)

i = Bus.audio(s, 2);
~effect4 = Synth(\effect4, [\in, i]);
Synth(\bufferPlayer, [\buffer, ~loops[0], \out, i]);