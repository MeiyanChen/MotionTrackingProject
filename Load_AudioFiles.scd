//load the audio file

(
~loops = Array.new;
~folder1 = PathName.new("/Users/meiyanchen/Desktop/MotionTrackingProject/GitRepo/Audio/Loops/");


~folder1.entries.do({
	arg path;
	~loops = ~loops.add(Buffer.read(s, path.fullPath));
});




~pencilwriting = Array.new;
~folder2 = PathName.new("/Users/meiyanchen/Desktop/MotionTrackingProject/GitRepo/Audio/PencilWriting/");


~folder2.entries.do({
	arg path;
	~pencilwriting = ~pencilwriting.add(Buffer.read(s, path.fullPath));
});
)


/*
play it raw
~loops[0].play;  //1.1   6   bar
~loops[1].play;  //1.2   6   bar
~loops[2].play;  //1.3   6   bar
~loops[3].play;  //2     9   bar
~loops[4].play;  //3.1   10  bar
~loops[5].play;  //3.2   9   bar
~loops[6].play;  //3.3   9.5 bar
~loops[7].play;  //5     9   bar
~loops[8].play;  //5     8   bar



~pencilwriting[0].play; //Quick
~pencilwriting[1].play; //Quick
~pencilwriting[2].play; //Quick
~pencilwriting[3].play; //Quick
~pencilwriting[4].play; //Slow
~pencilwriting[5].play; //Slow
~pencilwriting[6].play; //Slow
~pencilwriting[7].play; //Slow
~pencilwriting[8].play; //Slow


