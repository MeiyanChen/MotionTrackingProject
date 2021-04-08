// also defines ~projectPath
"1_Load_AudioFiles.scd".loadRelative;

( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

( // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.play;
)


(

SynthDef(\bufferPlayer, {|buffer=0, out=0, pan = -1|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out,  Pan2.ar(sig, pan));
}).add;


SynthDef(\reverb, { |in, out, wet = 0.9,t60 = 1.2, damp = 0.1, size = 1.2, earlyDiff= 0.6, modDepth= 0.1, modFreq = 1.0, low = 0.5, mid = 1.0, high = 1.0 |
	var drySignal, wetSignal, rev, pan;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,t60, damp, size, earlyDiff, modDepth, modFreq, low, mid, high);
	//pan = Pan2.ar(drySignal, In.kr(c, 1) * 2 - 1);
	wetSignal = drySignal + rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;

)

( // probably best put into loadAudioFiles
~kickHeavyBuffer = Buffer.read(s, ~projectPath ++ "Buffers/Loops/01HeavyKickLoop_V2_TouchOSC.wav");
~orchestraLoop1_1Buffer = Buffer.read(s, ~projectPath ++ "Buffers/Orchestra/Loop1_1.aif");
)

// option 1------------------------------------------------------------------------------------------
(
var sequence, stream, nextFunction;

~beat0 = ~kickHeavyBuffer;
~beat1 = ~loops.choose.postln;
~beat2 = ~loops.choose.postln;
~orchestra1 = ~orchestraLoop1Buffer;
~orchestra2 = ~orchestraMiddle.choose.postln;
~orchestra3 = ~orchestraEnd.choose.postln;

sequence = Pseq([
	[~beat0],
	[~orchestra1, ~beat1],
	[~orchestra2, ~beat2],
	[~orchestra3, ~beat3], inf
]);

stream = sequence.asStream;

Routine({
    loop({
		var samples = stream.next;
		samples.do {|sample|
			Synth(\bufferPlayer, [\buffer, sample.postln]);
		};
		(8*5*0.5).wait;
	})
}).play;
)


(
f = Bus.audio(s, 2);  //reverb
~reverb = Synth(\reverb, [\in, f]);
)

// option 2
//-------------------------------------------------------------------------------------------------
(
Tdef(\a, { inf.do {
		var buffer0;
	    var buffer1;
		buffer0 = ~kickHeavyBuffer;
		~beat0 = Synth(\bufferPlayer, [\buffer, buffer0, \out, f]);
		 (8*5*0.5).wait;
		buffer1 = ~orchestraLoop1_1Buffer;
		~orchestra1 = Synth(\bufferPlayer, [\buffer, buffer1, \out, f]);
		 (6*4*0.5).wait;
	}});
)

(
Tdef(\b, { 4.do {
		var buffer1;
		buffer1 = ~orchestraLoop1_1Buffer;
		~orchestra1 = Synth(\bufferPlayer, [\buffer, buffer1, \out, f]);
		 (6*4*0.5).wait;
	}});
)

(
Tdef(\c, { inf.do {
		var buffer2;
		buffer2 = ~loops.choose.postln;
		~beat2 = Synth(\bufferPlayer, [\buffer, buffer2, \out, f]);
		 (8*5*0.5).wait;
	}});
)

(
Tdef(\d, {
    "fork - parallel.".postln;
    0.2.wait;
    Tdef(\a).fork;
    1.wait;
    Tdef(\b).fork;
    1.wait;
    Tdef(\c).fork;

    "done.".postln;
});
)
Tdef(\d).play;



Tdef(\bufferPlayer).play;
~keepLooping = false;
Tdef(\bufferPlayer).stop;

// option 3------------------------------------------------------------------------
(
Tdef(\bufferPlayer, {

	f = Bus.audio(s, 2);  //reverb
	~reverb = Synth(\reverb, [\in, f]);

	inf.do {
		var buffer0;
		buffer0 = ~kickHeavyBuffer;
		~beat0 = Synth(\bufferPlayer, [\buffer, buffer0, \out, f]);
		 (8*5*0.5).wait;
	};

	4.do {
		var buffer1;
		buffer1 = ~orchestraLoop1_1Buffer;
		~orchestra1 = Synth(\bufferPlayer, [\buffer, buffer1, \out, f]);
		 (6*4*0.5).wait;
	};

	inf.do {
		var buffer2;
		buffer2 = ~loops.choose.postln;
		~beat2 = Synth(\bufferPlayer, [\buffer, buffer2, \out, f]);
		 (8*5*0.5).wait;
	};

	15.do {
		var buffer3;
		buffer3 = ~orchestraMiddle.choose.postln;
		~orchestra3 = Synth(\bufferPlayer, [\buffer, buffer3, \out, f]);
        (10*4*0.5).wait;
	};

	inf.do {
		var buffer4;
		buffer4 = ~loops.choose.postln;
		~beat4 = Synth(\bufferPlayer, [\buffer, buffer4, \out, f]);
		(8*5*0.5).wait;

	};

	2.do {
		var buffer5;
		buffer5 = ~orchestraEnd.choose.postln;
		~orchestra5 = Synth(\bufferPlayer, [\buffer, buffer5, \out, f]);
        (9*5*0.5).wait;
	};

	inf.do {
		var buffer6;
		buffer6 = ~loops.choose.postln;
		~beat6 = Synth(\bufferPlayer, [\buffer, buffer6, \out, f]);
		(12*5*0.5).wait;

	};

	inf.do {
		var buffer7;
		buffer7 = ~loops.choose.postln;
		~beat7 = Synth(\bufferPlayer, [\buffer, buffer7, \out, f]);
        (14*5*0.5).wait;
	};

	inf.do {
		var buffer8;
		buffer8 = ~loops.choose.postln;
		~beat8 = Synth(\bufferPlayer, [\buffer, buffer8, \out, f]);
		(16*5*0.5).wait;

	};

	inf.do {
		var buffer9;
		buffer9 = ~loops.choose.postln;
		~beat9 = Synth(\bufferPlayer, [\buffer, buffer9, \out, f]);
        (16*5*0.5).wait;
	};


});
)
