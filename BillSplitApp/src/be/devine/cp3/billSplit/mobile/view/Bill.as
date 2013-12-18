package be.devine.cp3.billSplit.mobile.view {
import be.devine.cp3.billSplit.mobile.view.controls.navButton;

import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import flash.text.SoftKeyboardType;

import starling.display.DisplayObject;

import starling.events.Event;
import starling.events.ResizeEvent;

public class Bill extends Screen
{
    public static const CLICKED:String = "clicked";

    private var _btnHome:navButton;
    private var _btnPrevious:navButton;
    private var _list:List;

    public function Bill()
    {
        _btnHome = new navButton('home');
        _btnHome.label = 'home';
        _btnHome.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _btnPrevious = new navButton('split');
        _btnPrevious.label = 'previous';
        _btnPrevious.addEventListener( starling.events.Event.TRIGGERED, triggeredHandler );

        _header.leftItems = new <DisplayObject>[ _btnPrevious ];
        _header.rightItems = new <DisplayObject>[ _btnHome ];

        var arrList:Array = _appModel.createList();

        var listContent:ListCollection = new ListCollection(arrList);

        _list = new List();
        _list.dataProvider = listContent;
        addChild( _list );

        addEventListener(starling.events.Event.ADDED_TO_STAGE, addedHandler);
    }

    private function addedHandler(event:starling.events.Event):void
    {
        removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
        stage.addEventListener(Event.RESIZE, resizeHandler);
        addEventListener(Event.REMOVED_FROM_STAGE, removedHandler);

        layout();
    }

    private function removedHandler(event:starling.events.Event):void {
        stageRef.removeEventListener(ResizeEvent.RESIZE, resizeHandler);

        layout();
    }

    private function triggeredHandler(event:starling.events.Event):void
    {
        var button:navButton = navButton(event.currentTarget);
        _appModel.destination = button.destination;
        dispatchEventWith(CLICKED, true);
    }

    private function resizeHandler(event:starling.events.Event):void
    {
        layout();
    }

    private function layout():void
    {
        _header.title = 'Da Bill';
        _header.setSize(stage.stageWidth, 120);

        _list.y = _header.height + 20;
        _list.width = stage.stageWidth;
        _list.height = stage.stageHeight - _list.y;
    }
}
}