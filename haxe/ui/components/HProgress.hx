package haxe.ui.components;

import haxe.ui.core.Component;
import haxe.ui.core.MouseEvent;
import haxe.ui.layouts.DefaultLayout;
import haxe.ui.core.IClonable;

/**
 A horizontal implementation of a `Slider`
**/
@:dox(icon="/icons/ui-progress-bar.png")
class HProgress extends Progress implements IClonable<HProgress> {
    public function new() {
        super();
    }

    //***********************************************************************************************************
    // Internals
    //***********************************************************************************************************
    private override function createDefaults():Void {
        super.createDefaults();
        _defaultLayout = new HProgressLayout();
    }

    private override function createChildren():Void {
        super.createChildren();
        if (componentWidth <= 0) {
            componentWidth = 150;
        }
        if (componentHeight <= 0) {
            componentHeight = 20;
        }
    }
}

//***********************************************************************************************************
// Custom layouts
//***********************************************************************************************************
@:dox(hide)
class HProgressLayout extends DefaultLayout {
    public function new() {
        super();
    }

    public override function resizeChildren() {
        super.resizeChildren();

        var value:Component = component.findComponent("progress-value");
        var progress:Progress = cast component;
        if (value != null) {
            var ucx:Float = usableWidth;

            var cx:Float = 0;
            if (progress.rangeStart == progress.rangeEnd) {
                cx = (progress.pos - progress.min) / (progress.max - progress.min) * ucx;
            } else {
                cx = ((progress.rangeEnd - progress.rangeStart) - progress.min) / (progress.max - progress.min) * ucx;
            }

            if (cx < 0) {
                cx = 0;
            } else if (cx > ucx) {
                cx = ucx;
            }

            if (cx == 0) {
                value.componentWidth = 0;
                value.hidden = true;
            } else {
                value.componentWidth = cx;
                value.hidden = false;
            }
        }
    }

    public override function repositionChildren():Void {
        super.repositionChildren();

        var value:Component = component.findComponent("progress-value");
        var progress:Progress = cast component;
        if (value != null) {
            if (progress.rangeStart != progress.rangeEnd) {
                var ucx:Float = usableWidth;
                value.left = paddingLeft + (progress.rangeStart - progress.min) / (progress.max - progress.min) * ucx;
            }

        }
    }
}