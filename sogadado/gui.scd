var initWindow = {
	var lblSound, lblInput, lblPanel, lblTitle, hLayout, popUpSounds, popUpOutput;
	var palette = QPalette.auto();

	palette.windowText = Color.black;
	palette.button = Color.red;

	QtGUI.palette = palette;

	lblSound = StaticText().string = "Sounds:";
	lblInput = StaticText( ).string = "Output:";
	lblPanel = StaticText( ).string = "Control Panel";
	lblTitle = StaticText( ).string = "ソガダド";
	lblTitle.stringColor = Color.red;

	lblTitle.font = Font.sansSerif( 30 );
	lblPanel.font = Font.sansSerif( 30 );

	//select synth drop down list
	popUpSounds = PopUpMenu().background_(Color.black);
	popUpSounds.items = ~sounds.keys.as(Array);

	~currentSound = popUpSounds.item;
	~midiSynthConnect.value(popUpSounds.item);

	popUpSounds.action = { arg menu;
		~currentSound = menu.item;
		~midiSynthConnect.value(menu.item);
		updateKnobs.();
	};

	//audio output drop down list
	popUpOutput = PopUpMenu().background_(Color.black);
	popUpOutput.items = ["Select audio output"]++ServerOptions.outDevices;
	popUpOutput.action = { arg menu;
		~selectAudioOutput.value(menu.item);
	};

	~mainWindow = Window.new("ソガダド").layout_(
		VLayout(
			lblTitle,
			HLayout(
				VLayout(lblSound, popUpSounds).spacing_(5),
				VLayout(lblInput, popUpOutput).spacing_(5)).margins_([10, 30, 10, 30]),
			lblPanel,
			initKnobs.()
).setAlignment(lblPanel, \center).setAlignment(lblTitle, \center)).background_(Color.white);

	//~mainWindow.onClose_({CmdPeriod.run;}); //stop everything when user closes window
	//Server.hardFreeAll;

	~mainWindow.onClose_({Server.killAll;}); //stop everything when user closes window
};

var initKnobs = {
	var currentItem = ~sounds[~currentSound];
	var hLayout = HLayout();
	~knobs = Array.new(currentItem.size);

	currentItem.do({ arg item, i;
		var knob = Knob().action_(item[1]);
		var label = StaticText().string_(item[0]);
		var vLayout = VLayout(label, knob);

		knob.value = ~paramValues[i];
		knob.color = [Color.red, Color.black, Color.white, Color.black];
		vLayout.setAlignment(label, \center);
		vLayout.setAlignment(knob, \center);
		vLayout.spacing = 5;
		vLayout.margins = [10, 30, 10, 30];

		~knobs.add([label, knob]);
		hLayout.add(vLayout);
	});
	~knobs.postln;
	hLayout;
};
/*
var startSynth = {
	if (~currentSynth.notNil())
	{
	    ~currentSynth.run(false);
		~currentSynth.free;
	};

	~currentSynth = Synth.new( ~currentSound );
	~currentSynth.run;
};
*/
var showWindow = {
	~mainWindow.front();
};

var updateKnobs = {
	var currentItem = ~sounds[~currentSound];
	currentItem.do({ arg item, i;
		~knobs[i][0].string = item[0];
		~knobs[i][1].action = item[1];
	});

	//startSynth.();
};

initWindow.();

showWindow.();