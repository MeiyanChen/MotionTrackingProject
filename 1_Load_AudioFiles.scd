//load the audio file
~out = 0;
~path = PathName(thisProcess.nowExecutingPath).parentPath++"buffers/";


//3. define piece-specific functions
~makeBuffers = {
	b = Dictionary.new;
	PathName(~path).entries.do{
		arg subfolder;
		b.add(
			subfolder.folderName.asSymbol ->
			Array.fill(
				subfolder.entries.size,
				{
					arg i;
					Buffer.read(s, subfolder.entries[i].fullPath);
				}
			)
		);
	};
};

b[\Loops][2];

(

~loops = Array.new;
~folder1 = PathName(thisProcess.nowExecutingPath).parentPath++ "Buffers/Loops/";


~folder1.entries.do({
	arg path;
	~loops = ~loops.add(Buffer.read(s, path.fullPath));
});




~pencilwriting = Array.new;
~folder2 = PathName(thisProcess.nowExecutingPath).parentPath++ "Buffers/PencilWriting/";


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



~pencilwriting[0].play; //Mono Quick
~pencilwriting[1].play; //Mono Quick
~pencilwriting[2].play; //Mono Quick
~pencilwriting[3].play; //Mono Quick
~pencilwriting[4].play; //Mono Slow
~pencilwriting[5].play; //Mono Slow
~pencilwriting[6].play; //Mono Slow
~pencilwriting[7].play; //Mono Slow
~pencilwriting[8].play; //Mono Slow

~pencilwriting[9].play;  //Stereo Quick
~pencilwriting[10].play; //Stereo Quick
~pencilwriting[11].play; //Stereo Quick
~pencilwriting[12].play; //Stereo Quick
~pencilwriting[13].play; //Stereo Slow
~pencilwriting[14].play; //Stereo Slow
~pencilwriting[15].play; //Stereo Slow
~pencilwriting[16].play; //Stereo Slow
~pencilwriting[17].play; //Stereo Slow


*/
