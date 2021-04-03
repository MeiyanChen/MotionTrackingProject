"1_Load_AudioFiles.scd".loadRelative;

(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;
)

//line
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
Synth(\bufferPlayer, [\buffer, ~loops[5], \endvalue, 10, \out, f]); // endvalue lower, effect more.

//BPF
(
SynthDef(\effect2, {|in, out, wet = 0.9|
	var drySignal, wetSignal, vib;
	drySignal = In.ar(in, 2);
	vib = BPF.ar(drySignal, MouseX.kr(1, 100, 1), 0.3);
	wetSignal = drySignal * (vib * 200 + 600);
	Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
//reduce wet, 1hz - 40hz, wet higher effect stronger
)
g = Bus.audio(s, 2);
~effect2 = Synth(\effect2, [\in, g]);
Synth(\bufferPlayer, [\buffer, ~loops[4], \out, g]);
Quark.checkout;

//HPF
(
SynthDef(\effect3, { |in, out,wet = 0.9|
	var drySignal, wetSignal, ctl;
	drySignal = In.ar(in, 2);
	ctl = HPF.ar(drySignal, MouseX.kr(20, 60, 1), 0.3);
	wetSignal = drySignal * ctl;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

h = Bus.audio(s, 2);
~effect3 = Synth(\effect3, [\in, h]);
Synth(\bufferPlayer, [\buffer, ~loops[5], \out, h]);

// Delay

(
SynthDef(\effect4, {|in, out,wet = 0.5,  decaytime = 15|
	var drySignal, wetSignal, delay;
	drySignal = In.ar(in, 2);
	delay = CombN.ar( drySignal, 0.2, 0.2, decaytime);
	wetSignal = drySignal * delay;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

i = Bus.audio(s, 2);
~effect4 = Synth(\effect4, [\in, i]);
Synth(\bufferPlayer, [\buffer, ~loops[5], \out, i]);

(
SynthDef(\effect5, { |in, out, wet = 0.9, size = 1 , earlyDiff = 0.707|
	var drySignal, wetSignal, rev;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,1, MouseX.kr(0.0, 1.0), MouseX.kr(0.5, 4.0));
	wetSignal = drySignal * rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

(
SynthDef(\effect5, { |in, out, wet = 0.5, t60 = 1.0, damp = 0.0, size = 1.0, earlyDiff = 0.707, modDepth = 0.1, modFreq = 2.0, low = 1.0, mid = 1.0, high = 1.0, lowcut = 500.0, highcut = 2000.0|
	var drySignal, wetSignal, rev;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,t60, damp, size, earlyDiff, modDepth, modFreq, low, mid, high, lowcut, highcut);
	wetSignal = drySignal * rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;
)

j = Bus.audio(s, 2);
~effect5 = Synth(\effect5, [\in, j]);
Synth(\bufferPlayer, [\buffer, ~loops[7], \out, j]);