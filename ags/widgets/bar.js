import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import SystemTray from 'resource:///com/github/Aylur/ags/service/systemtray.js';
import Clock from './Clock.js'; //Clock widget
//Hyprland for workspaces
import Hyprland from 'resource:///com/github/Aylur/ags/service/hyprland.js';

const LeftWidgets = () => Widget.Box({
  class_name: 'left-widgets',
  hpack: 'start',
  spacing: 8,
  children: [Clock()],
})

const CenterWidgets = () => Widget.Box({
    class_name: 'bar-center-widgets',
    hpack: 'center', // Pack to the center
    spacing: 8,
    children: [
        Widget.Box({
            children: Hyprland.bind('workspaces').transform(ws => {
                return ws.sort((a, b) => a.id - b.id).map(({ id }) => Widget.Button({
                    on_clicked: () => Hyprland.messageAsync(`dispatch workspace ${id}`),
                    child: Widget.Label(`${id}`),
                    class_name: Hyprland.active.workspace.bind('id')
                        .transform(activeId => `${activeId === id ? 'focused' : ''}`),
                }));
            }),
        }),
    ],
});

const RightWidgets = () => Widget.Box({
  class_name: 'right-widgets',
  hpack: 'end', //to the right cro
  spacing: 8,
  children: [],

})


export const Bar = (monitor = 0) => Widget.Window({
  name: 'bar-${monitor}',
  class_name: 'floating-island',
  anchor: ['top'], 
  exclusivity: 'ignore', //floating island, no space reserved
  child: Widget.Box({
	class_name : 'bar-context-box',
	children: [
		CentetWidgets(),
		],
	})



})


