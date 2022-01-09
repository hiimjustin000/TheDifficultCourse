package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class MenuState extends FlxState {
    var worm1: Worm;
    var worm2: Worm;

    var curSelected: Int = 0;
    var menuItems: FlxTypedGroup<Grand9K>;

    override public function create() {
        super.create();

        worm1 = new Worm();
        add(worm1);
        worm2 = new Worm(1120, 700, true);
        add(worm2);

        menuItems = new FlxTypedGroup<Grand9K>();
        add(menuItems);
    }

    var beat: Int = 0;
    override public function update(elapsed: Float)
    {
        super.update(elapsed);

        var oldBeat = beat;
        beat = Math.floor(FlxG.sound.music.time / (12 / 35 * 1000));

        if (oldBeat != beat) {
            worm1.move();
            worm2.move();
        }

        if (Game.Controls.UP_P)
            changeSelection(-1);

        if (Game.Controls.DOWN_P)
            changeSelection(1);

        if (Game.Controls.FULLSCREEN)
            FlxG.fullscreen = !FlxG.fullscreen;
    }

    function changeSelection(change: Int = 0) {
        curSelected += change;

        if (curSelected < 0)
            curSelected = menuItems.length - 1;
        if (curSelected >= menuItems.length)
            curSelected = 0;

        menuItems.forEach(menuItem -> {
            if (menuItem.ID == menuItems.members[curSelected].ID)
                menuItem.color = 0xFFFFFFFF;
            else
                menuItem.color = 0xFF808080;
        });
    }
}
