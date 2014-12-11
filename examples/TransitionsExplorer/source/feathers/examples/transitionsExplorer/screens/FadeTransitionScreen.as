package feathers.examples.transitionsExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PanelScreen;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.motion.transitions.Fade;

	import starling.display.DisplayObject;

	import starling.events.Event;

	public class FadeTransitionScreen extends PanelScreen
	{
		public static const TRANSITION:String = "transition";

		public function FadeTransitionScreen()
		{
			super();
		}

		private var _list:List;
		private var _backButton:Button;

		private var _fadeInTransition:Function = Fade.createFadeInTransition();
		private var _fadeOutTransition:Function = Fade.createFadeOutTransition();
		private var _crossfadeTransition:Function = Fade.createCrossfadeTransition();

		override protected function initialize():void
		{
			//never forget to call super.initialize()
			super.initialize();

			this.layout = new AnchorLayout();

			this._list = new List();
			this._list.dataProvider = new ListCollection(
			[
				{ label: "Fade In", transition: this._fadeInTransition },
				{ label: "Fade Out", transition: this._fadeOutTransition },
				{ label: "Crossfade", transition: this._crossfadeTransition },
			]);
			this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
			this._list.clipContent = false;
			this._list.autoHideBackground = true;

			this._list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();

				//enable the quick hit area to optimize hit tests when an item
				//is only selectable and doesn't have interactive children.
				renderer.isQuickHitAreaEnabled = true;

				renderer.labelField = "label";
				return renderer;
			};

			this._list.addEventListener(Event.TRIGGERED, list_triggeredHandler);
			this._list.revealScrollBars();
			this.addChild(this._list);

			this.headerFactory = this.customHeaderFactory;
		}

		private function customHeaderFactory():Header
		{
			var header:Header = new Header();
			header.title = "Fade";

			this._backButton = new Button();
			this._backButton.styleNameList.add(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON);
			this._backButton.label = "Transitions";
			this._backButton.addEventListener(Event.TRIGGERED, backButton_triggeredHandler);
			header.leftItems = new <DisplayObject>[this._backButton];

			return header;
		}

		private function list_triggeredHandler(event:Event, item:Object):void
		{
			var transition:Function = item.transition as Function;
			this.dispatchEventWith(TRANSITION, false, transition);
		}

		private function backButton_triggeredHandler(event:Event):void
		{
			this.dispatchEventWith(Event.COMPLETE);
		}
	}
}
