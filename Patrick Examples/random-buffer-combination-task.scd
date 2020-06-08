(
b = [
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/PencilWriting/PencilQ1.aif",
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/PencilWriting/PencilQ2.aif",
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/PencilWriting/PencilQ3.aif",
	"C:/Users/patri/Documents/src/MotionTrackingProject/Audio/PencilWriting/PencilQ4.aif",
];

b = b.collect {|path| Buffer.read(s, path)};


)

b.choose.duration

(
SynthDef(\bufferPlayer, {|buffer=0, out=0|
	var sig = PlayBuf.ar(2, buffer, doneAction:2);
	Out.ar(out, sig);
}).add;
)

(
Tdef(\pencilFast, {
	inf.do {
		var buffer = b.choose;
		Synth(\bufferPlayer, [\buffer, buffer]);
		buffer.duration.wait;
	}
});
)

Tdef(\pencilFast).play;
Tdef(\pencilFast).stop;

// most funnest Ugens in SuperCollider!
GrainBuf