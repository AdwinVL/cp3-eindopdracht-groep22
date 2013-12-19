package be.devine.cp3.billSplit.model {
import be.devine.cp3.billSplit.mobile.view.payers.Payer;

import flash.events.Event;

import flash.events.EventDispatcher;

public class AppModel extends EventDispatcher
{
    private static var instance:AppModel;

    public static const PRICE_CHANGED:String = "currentPageChanged";

    private var _destination:String = "";

    private var _payers:uint = 3;
    private var _arrPayers:Array;
    private var _price:uint = 0;
    private var _procent:uint;
    private var _fixations:uint;

    public static function getInstance():AppModel
    {
        if (instance == null) {
            instance = new AppModel(new Enforcer());
        }
        return instance;
    }

    public function AppModel(e:Enforcer)
    {
        if (e == null)
        {
            throw new Error("AppModel is a singleton, use getInstance() instead");
        }

        _arrPayers = [];
    }

    [Bindable(event="destinationChanged")]
    public function get destination():String
    {
        return _destination;
    }

    public function set destination(value:String):void
    {
        if (_destination == value) return;
        _destination = value;
    }

    public function get payers():uint
    {
        return _payers;
    }

    public function set payers(value:uint):void
    {
        _payers = value;
    }

    public function get price():uint
    {
        return _price;
    }

    public function set price(value:uint):void
    {
        if (_price == value) return;
        _price = value;

        dispatchEvent(new Event(PRICE_CHANGED));
    }
    public function get arrPayers():Array
    {
        return _arrPayers;
    }

    public function set arrPayers(value:Array):void
    {
        _arrPayers = value;
    }

    public function updatePrices():void
    {
        for each(var payer:Payer in _arrPayers)
        {
            payer.totalAmount.text = "€ " + Math.round(_price / 100 * payer.slider.value);
        }
    }

    public function countFixations():void
    {
        _fixations = 0;

        for each(var payer:Payer in _arrPayers)
        {
            if(payer.sliderChanged == true)
            {
                _fixations ++;
            }
        }

        if(_fixations == _payers)
        {
            for each(var payer2:Payer in _arrPayers)
            {
                payer2.sliderChanged = false;
            }
        }
    }

    public function updateSliders(id:String, value:Number):void
    {
        _procent = 100;

        countFixations();

        for each(var payer:Payer in _arrPayers)
        {
            if(payer.payerName.text == id || payer.sliderChanged == true)
            {
                payer.percentage.text = payer.slider.value.toString() + "%";
                payer.totalAmount.text = "€ " + Math.round(_price / 100 * payer.slider.value);

                _procent -= payer.slider.value;
            }
            else
            {
                countFixations();

                payer.slider.value = (_procent / (_payers - _fixations));
                payer.percentage.text = payer.slider.value.toString() + "%";
                payer.totalAmount.text = "€ " + Math.round(_price / 100 * payer.slider.value);
            }
        }
    }

    public function get procent():uint
    {
        return _procent;
    }

    public function set procent(value:uint):void
    {
        _procent = value;
    }

    public function createList():Array
    {
        var arrList:Array = [];

        for each(var payer:Payer in _arrPayers)
        {
            var payerStats:String = payer.payerName.text + ", you pay € " + payer.totalAmount.text;
            arrList.push(payerStats);
        }
        return arrList;
    }
}
}

internal class Enforcer {}