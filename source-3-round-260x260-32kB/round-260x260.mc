using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

//! inherit from the view that contains the commonlogic
class DeviceView extends PowerView {
	var myTime;
	var strTime;

	//! it's good practice to always have an initialize, make sure to call your parent class here!
    function initialize() {
        PowerView.initialize();
    }

	function onUpdate(dc) {
		//! call the parent function in order to execute the logic of the parent
		PowerView.onUpdate(dc);

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal thirds
        dc.drawLine(40,  30, 220, 30);
        dc.drawLine(3,   100, 257, 100);
        dc.drawLine(3,   169, 257, 169);

        //! Top vertical divider
        dc.drawLine(129, 30,  129, 100);

        //! Centre vertical divider
        dc.drawLine(178, 100,  178, 169);

        //! Bottom vertical divider
        dc.drawLine(129, 169, 129, 237);
        
        //! Bottom horizontal divider
        dc.drawLine(53, 237, 220, 237);

        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		//! Show clock with current time in top
		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
        dc.drawText(130, -3, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		
		//! Display metrics
		for (var i = 1; i < 7; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"075,073,079,014,081,073,040");
	       	} else if ( i == 2 ) {	//!upper row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"184,073,194,131,081,181,040");
	       	} else if ( i == 3 ) {  //!middle row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"103,133,109,029,150,009,152");
	       	} else if ( i == 4 ) {  //!middle row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"219,142,000,000,000,220,109");
	       	} else if ( i == 5 ) {	//!lower row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"076,191,079,014,185,080,225");
	       	} else if ( i == 6 ) {	//!lower row, right
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"183,191,192,131,187,170,225");
	       	}      	
		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(100, 240, 59, 16);
		dc.fillRectangle(159, 243, 3, 9);

		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 102 + Math.round(pwr*0.55)  ;
		var Endstatuspwrbr = 55 - Math.round(pwr*0.55) ;
		dc.fillRectangle(Startstatuspwrbr, 242, Endstatuspwrbr, 12);	
	   
	}
}