/**
 * Created by School on 19/12/13.
 */
package be.devine.cp3.billSplit.mobile.view.payers {
import be.devine.cp3.billSplit.mobile.view.controls.PriceTag;

import feathers.controls.Button;

import starling.display.Stage;
import starling.events.Event;

public class CostumPayer extends BasePayer {

    private var _addBtn:Button;
    private var _arrPriceTags:Array = [];
    private var _priceTag:PriceTag;

    public function CostumPayer(i:uint, stageRef:Stage)
    {
        super(i, stageRef);

        _addBtn = new Button();

        _addBtn.x = _icon.x + _icon.width + 15;
        _addBtn.y = _payerName.y + _payerName.fontSize + 15;
        _addBtn.label = '+';
        _addBtn.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        addChild(_addBtn);
    }
    private function triggeredHandler(event:starling.events.Event):void
    {
        trace("add clicked");
        _priceTag = new PriceTag(20);
        _arrPriceTags.push(_priceTag);

        priceTagLayout();
    }
    // COSTUM
    private function priceTagLayout():void {

        var columns:uint = 4;

        var xPos:uint;
        var yPos:uint;

        xPos = _addBtn.x + _addBtn.width + 15;
        yPos = _addBtn.y;

        for(var i:uint = 0; i<_arrPriceTags.length; i++){

            _arrPriceTags[i].x = xPos;
            _arrPriceTags[i].y = yPos;
            addChild(_arrPriceTags[i]);

            xPos += (_arrPriceTags[i].width + 10);

            if((i+1) % columns == 0) // veelvoud van aantal columns
            {
                yPos += (_arrPriceTags[i - 1].height + 5);
                xPos = _addBtn.x + _addBtn.width + 15;
            }
        }
    }
}
}
