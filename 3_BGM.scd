// also defines ~projectPath
"1_Load_AudioFiles.scd".loadRelative;

( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

/*
( // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.play;
)
*/

(

SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out,  sig* In.kr(c, 1).linexp(0, 1, 0.1,0.7) *In.kr(d, 1).linexp(0, 1, 0.5, 1.5));
}).add;


SynthDef(\reverb, { |in, out, wet = 0.9,t60 = 1, damp = 0, size = 1.2, earlyDiff= 0.5, modDepth= 0.1, modFreq = 2.0, low = 1.0 , mid = 1.0, high = 1.0 |
	var drySignal, wetSignal, rev;
	drySignal = In.ar(in, 2);
	rev = JPverb.ar(drySignal,t60, damp, size, earlyDiff, modDepth, modFreq, low, mid, high);
	//pan = Pan2.ar(drySignal, In.kr(c, 1) * 2 - 1);
	wetSignal = drySignal + rev;
    Out.ar(out, (drySignal *(1.0 - wet)) + (wetSignal *wet));
}).add;

)



// option 1------------------------------------------------------------------------------------------
(
var sequence, stream, nextFunction;

f = Bus.audio(s, 2);  //reverb
~reverb = Synth(\reverb, [\in, f]);

~beat0 = ~kickHeavyBuffer;
~beat1 = ~loops.choose.postln;
~beat2 = ~loops.choose.postln;
~beat3 = ~loops.choose.postln;
~beat4 = ~loops.choose.postln;
~beat5 = ~loops.choose.postln;
~beat6 = ~loops.choose.postln;
~beat7 = ~loops.choose.postln;
~beat8 = ~loops.choose.postln;
~orchestra0 = ~orchestraLoop1_1Buffer;
~orchestra1 = ~orchestraStart.choose.postln;
~orchestra2 = ~orchestraStart.choose.postln;
~orchestra3 = ~orchestraMiddle.choose.postln;
~orchestra4 = ~orchestraMiddle.choose.postln;
~orchestra5 = ~orchestraMiddle.choose.postln;
~orchestra6 = ~orchestraMiddle.choose.postln;
~orchestra7 = ~orchestraMiddle.choose.postln;
~orchestra8 = ~orchestraMiddle.choose.postln;
~orchestra9 = ~end1Buffer;
~orchestra10 = ~end2Buffer;


sequence = Pseq([
	[~beat0],
	[~orchestra0, ~beat0,~beat1],
	[~orchestra1, ~beat0, ~beat1,~beat2],
	[~orchestra2, ~beat1, ~beat2,~beat3],
	[~orchestra3, ~beat1, ~beat2,~beat3,~beat4],
	[~orchestra3, ~beat1, ~beat2,~beat3,~beat4,~beat5],
	[~orchestra4, ~beat2, ~beat3,~beat4,~beat5,~beat6,~beat7],
	[~orchestra4, ~beat2, ~beat3,~beat4,~beat5,~beat6,~beat7,~beat8],
	[~orchestra5, ~beat3, ~beat4,~beat5,~beat6,~beat7,~beat8,~beat0,~beat1],
	[~orchestra5, ~beat3, ~beat4,~beat5,~beat6,~beat7,~beat8,~beat0,~beat1],
	[~orchestra6, ~beat4, ~beat5,~beat6,~beat7,~beat8,~beat0,~beat1,~beat2],
	[~orchestra6, ~beat4, ~beat5,~beat6,~beat7,~beat8,~beat0,~beat1,~beat2,~beat3],
	[~orchestra6, ~beat4, ~beat5,~beat6,~beat7,~beat8,~beat0,~beat1,~beat2,~beat3],
	[~orchestra6, ~beat4, ~beat5,~beat6,~beat7,~beat8,~beat0,~beat1,~beat2,~beat3],
    [~orchestra7, ~beat5, ~beat6,~beat7,~beat8,~beat0,~beat1,~beat2,~beat3],
	[~orchestra7, ~beat5, ~beat6,~beat7,~beat8,~beat0,~beat1,~beat2,~beat4],
    [~orchestra7, ~beat5, ~beat6,~beat7,~beat8,~beat0,~beat1,~beat2],
	[~orchestra8, ~beat5, ~beat6,~beat7,~beat8,~beat2,~beat1],
	[~orchestra8, ~beat6, ~beat7,~beat8,~beat0,~beat1],
	[~orchestra8, ~beat6, ~beat7,~beat8,~beat2],
	[~orchestra8, ~beat7,~beat6,~beat4],
	[~orchestra9, ~beat1, ~beat8,~beat0],
	[~orchestra10,~beat2,~beat0],
	[~beat8,~beat0],
	[~beat0],
], 1);

stream = sequence.asStream;


Routine({
    loop({
		var samples = stream.next;
		samples.do {|sample|
			Synth(\bufferPlayer, [\buffer, sample.postln, \out, f]);
		};
		(8*5*0.5).wait;
	})
}).play;
)

/*

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
