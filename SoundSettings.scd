//Sound Settings
//load the audio file

(
~material1 = Array.new;
~folder1 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/Material1Ochestra/Bounces/");


~folder1.entries.do({
	arg path;
	~material1 = ~material1.add(Buffer.read(s, path.fullPath));
});




~material2 = Array.new;
~folder2 = PathName.new("/Volumes/Samsung_T5/HFM Karlsruhe/Projects/Motion tracking project/PencilSound/");


~folder2.entries.do({
	arg path;
	~material2 = ~material2.add(Buffer.read(s, path.fullPath));
});
)


( // create Control Busses
c = Bus.control(s, 1); // X from 0 to 1
d = Bus.control(s, 1); // Y from 0 to 1
e = Bus.control(s, 1); // Writing (1) or not Writing (0)
)

c.set(0.5);

( // send MouseX/MouseY to control busses
{
	Out.kr(c, MouseX.kr(0, 1));
	Out.kr(d, MouseY.kr(0, 1));
}.play;
)


//play it raw
~material1[0].play;
~material1[1].play;
~material1[2].play;
~material1[3].play;
~material1[4].play;
~material1[5].play;
~material1[6].play;
~material1[7].play;

~material2[0].play;
~material2[1].play;


// Pencil Sound / writing -----------------------------------

(
Ndef(\writing,
	{ arg out=0, bufnum=0;
		var amp = In.kr(e, 1);
		var trig = Impulse.ar(4, [0, In.kr(c, 1)], 0.2);
		Out.ar(out,
			PlayBuf.ar(2,~material2[0], amp * BufRateScale.kr(~material2[0]), trig, In.kr(d, 1).linlin(0, 1, 0, BufFrames.kr(~material2[0])), 1)
		)
	}
).play;
)


Ndef(\writing).release.play


// SynthDefs
(
b = ~material1[2];  // change stems here

SynthDef(\buffer1, { |out, bufnum, start, trig, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.03, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env).dup);
}).add;

SynthDef(\buffer2, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.perc(0.01, time, 0.05, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env).dup);
}).add;

SynthDef(\buffer3, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.01, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env*SinOsc.ar(In.kr(c),linlin(0, 1, 20, 500))));
}).add;

SynthDef(\buffer4, { |out, bufnum, start, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.01, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env*SinOsc.ar(In.kr(d).linlin(0, 1, 400,800))));
}).add;



SynthDef(\buffer5, { |out, bufnum, start, trig, time, amp, rate = 1|
	var sig = PlayBuf.ar(2, bufnum,
		rate: rate * BufRateScale.kr(bufnum),
		startPos: start, loop: 0
	),
	env = EnvGen.kr(Env.linen(0.01, time, 0.06, level: amp),
		doneAction: Done.freeSelf);
	Out.ar(out, (sig * env * {     var vib = BRF.kr(SinOsc.kr([1, 3, 10], 0, [1, 0.5, 0.25]).sum, In.kr(c, 1), 0.3);
		SinOsc.ar(vib * 200 + 600) * 0.2 }).dup);
}).add;

)

//check the original stem here
b.play;



//phasing/ looping one of the stems we choose from the synthdef ´buffer1-4
(

var start = 0, end = 13,
beatsInLoop = 4,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

p = Pbind(
	\instrument, \buffer1,
	\bufnum, b,
	\amp, 0.5,
	\start, start * b.sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
).play(quant: [8, 4]);

q = Pn( Pfindur(8,
	Pbind(
		\instrument, \buffer2,
		\bufnum, b,
		\amp, 0.2,
		\start, start * b.sampleRate,
		\dur, beatsInLoop,
		\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
		\rate, Pfunc { thisThread.clock.tempo / originalTempo }
),inf).play(quant: [4, 4]);

r = Pbind(
	\instrument, \buffer3,
	\bufnum, b,
	\amp, 0.2,
	\start, start * b.sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
).play(quant: [4, 3.5]);

w = Pn(
	Pfindur(
		8,
		Pbind(
			\instrument, \buffer4,
			\bufnum, b,
			\amp, 0.4,
			\start, start * b.sampleRate,
			\dur, beatsInLoop,
			\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
			\rate, Pfunc { thisThread.clock.tempo / originalTempo }
		),
		inf
	).play(quant: [4, 2]);
)
)
)


// another effect to use synthdef
(var start = 0, end = 13,
beatsInLoop = 4,
originalTempo = beatsInLoop / (end - start);

TempoClock.tempo = originalTempo;

x = Pbind(
	\instrument, \buffer4,
	\bufnum, b,
	\amp, 0.8,
	\sustain, 10,
	\legato, 5,
	\timeOffset, Pseq([0, 1.5, 3], inf),
	\start, start * b.sampleRate,
	\dur, beatsInLoop,
	\time, Pkey(\dur) / Pfunc { thisThread.clock.tempo },
	\rate, Pfunc { thisThread.clock.tempo / originalTempo }
).play;

)

x.free;
release

// the end
(
x = { var src;
	src = PlayBuf.ar(2, ~material1[7], 1, (Impulse.kr(XLine.kr(0.1, 400, 30))));
	Splay.ar(src,In.kr(d, 1), 0.2, In.kr(d, 1));
}.play;
)

(
OSCdef(\qtm_result, {|msg|
	("QTM Reply: " ++ msg[1]).postln
}, "/qtm/cmd_res");

n = NetAddr("192.168.1.192", 22225);
n.sendMsg("/qtm", "Connect", NetAddr.langPort);
)


n.sendMsg("/qtm", "StreamFrames", "AllFrames", "3D");

// Stop Streaming:
n.sendMsg("/qtm", "StreamFrames", "Stop");

OSCRecorderGUI();

// Connect to Qualisis-----------------------------------------------
(
// \oben has to be a unique identifier for an OSCdef, does not need to reflect the labels name
OSCdef(\oben, {|msg, time, addr, recvPort|

	var coords = msg[1..3];
	var center = [-30, -80, 1350];
	var isWriting = 0.0;
	var dimensions = [1000, 1000];
	var x, y;

	coords = coords - center;

	(coords[1] < 0).if {
		isWriting = 1.0;
	};

	x = coords[0].linlin(dimensions[0]/2 * -1, dimensions[0]/2, 0, 1);
	y = coords[2].linlin(dimensions[1]/2 * -1, dimensions[1]/2, 0, 1);


	// uncomment to dump OSC messages

	(isWriting > 0.0).if ({
		[x, y].postln;
	});

	// takes absolute values of room coordinates and scales the values
	c.set(x);
	d.set(y);
	e.set(isWriting);
	// x.set(\mdepth, msg[3].abs.linlin(0, 2000, 0, 16));

	/*
	// also use the angles
	x.set(\amp, msg[4].abs.linexp(0, 180, 0.05, 1));
	x.set(\pan, msg[5].abs.linlin(0, 180, -1, 1));
	x.set(\ffreq, msg[6].abs.linlin(0, 180, 200, 20000));
	*/

}, "/qtm/3d/PEN_TIP"); // 6DOF name here
)
//  paper position 