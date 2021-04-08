

(
var processing = NetAddr("127.0.0.1", 57150);

// \oben has to be a unique identifier for an OSCdef, does not need to reflect the labels name
OSCdef(\xy1, {|msg, time, addr, recvPort|

	var x = msg[2];
	var y = msg[1];
	// uncomment to dump OSC messages
	// msg.postln;

	/*
	(isWriting > 0.0).if ({
		[x, y].postln;
	});
	*/

	// takes absolute values of room coordinates and scales the values
	c.set(x);
	d.set(y);
	processing.sendMsg("/poemPosTouch", x, y);
	// e.set(isWriting);
	// x.set(\mdepth, msg[3].abs.linlin(0, 2000, 0, 16));

	/*
	// also use the angles
	x.set(\amp, msg[4].abs.linexp(0, 180, 0.05, 1));
	x.set(\pan, msg[5].abs.linlin(0, 180, -1, 1));
	x.set(\ffreq, msg[6].abs.linlin(0, 180, 200, 20000));
	*/

}, '/1/multixy1/1'); // 6DOF name here
)


OSCFunc.trace(true);
//  paper position