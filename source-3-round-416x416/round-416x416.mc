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
		dc.drawLine(70,  49,  346, 49);
        dc.drawLine(0,   159,  412, 159);
        dc.drawLine(0,   270, 412, 270);

        //! Top vertical divider
        dc.drawLine(207, 51,  207, 159);

        //! Centre vertical divider
        dc.drawLine(284, 159,  284, 270);

        //! Bottom vertical divider
        dc.drawLine(207, 270, 207, 380);
        
        //! Bottom horizontal divider
        dc.drawLine(92, 380, 324, 380);
        
        //! Display GPS accuracy
		dc.setColor(mGPScolor, Graphics.COLOR_TRANSPARENT);
        dc.fillRectangle(18, 9, 114, 44); 
		if (uMilClockAltern == 1) {
		   dc.fillRectangle(313, 9, 95, 44);
		} else {
		   dc.fillRectangle(284, 9, 95, 44);
		}
		
        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
		//! Show number of laps or clock with current time in top
		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
		if (uMilClockAltern == 0) {		
			dc.drawText(208, -4, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		}

		//! Display metrics
		for (var i = 1; i < 7; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"120,117,126,020,134,126,064");
			} else if ( i == 2 ) {	//!upper row, right
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"294,117,312,211,132,290,064");
	       	} else if ( i == 3 ) {  //!middle row, left
	    		Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"157,215,175,043,242,013,242");
	       	} else if ( i == 4 ) {  //!middle row, right
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"351,227,000,000,000,349,174");
			} else if ( i == 5 ) {	//!lower row, left
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"122,308,126,027,294,138,363");
			} else if ( i == 6 ) {	//!lower row, right
				Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"294,308,312,211,322,272,363");
	       	}      	
		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(159, 385, 94, 27);
		dc.fillRectangle(253, 392, 6, 12);

		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 163 + Math.round(pwr*0.86)  ;
		var Endstatuspwrbr = 86 - Math.round(pwr*0.86) ;
		dc.fillRectangle(Startstatuspwrbr, 388, Endstatuspwrbr, 21);		
   
	}

}