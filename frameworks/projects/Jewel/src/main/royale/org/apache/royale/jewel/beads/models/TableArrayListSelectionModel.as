////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.royale.jewel.beads.models
{
	COMPILE::SWF{
	import flash.events.Event;
	}
	import org.apache.royale.collections.IArrayList;
	import org.apache.royale.core.IRollOverModel;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;

    /**
     *  The ArrayListSelectionModel class is a selection model for
     *  a dataProvider that is an ArrayList. It assumes that items
     *  can be fetched from the dataProvider using dataProvider.getItemAt(index).
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.9.4
     */
	public class TableArrayListSelectionModel implements IJewelSelectionModel, IRollOverModel
	{
        /**
         *  Constructor.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function TableArrayListSelectionModel()
		{
		}

		//IJewelSelectionModel
		private var _dispatcher:IEventDispatcher;
        public function get dispatcher():IEventDispatcher {
			if (!_dispatcher) {
				_dispatcher = new EventDispatcher(this) as IEventDispatcher;
            }
			return _dispatcher;
		}
        public function set dispatcher(value:IEventDispatcher):void{
			_dispatcher = value;
		}

		public function get hasDispatcher():Boolean{
			return !!_dispatcher;
		}

		//IEventDispatcher JS
		COMPILE::JS
		public function addEventListener(type:String, handler:Function, opt_capture:Boolean = false, opt_handlerScope:Object = null):void{
            dispatcher.addEventListener(type, handler, opt_capture, opt_handlerScope);
		}
		COMPILE::JS
		public function removeEventListener(type:String, handler:Function, opt_capture:Boolean = false, opt_handlerScope:Object = null):void{
            dispatcher.removeEventListener(type, handler, opt_capture, opt_handlerScope);
		}

		COMPILE::JS
		public function dispatchEvent(event:Object):Boolean{
			return dispatcher.dispatchEvent(event);
		}



        //IEventDispatcher SWF
		COMPILE::SWF
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
            dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		COMPILE::SWF
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
            dispatcher.removeEventListener(type, listener, useCapture);
		}

		COMPILE::SWF
		public function dispatchEvent(event:flash.events.Event):Boolean{
			return dispatcher.dispatchEvent(event);
		}

        COMPILE::SWF
        public function willTrigger(type:String):Boolean{
            return dispatcher.willTrigger(type);
        }

		//IEventDispatcher (shared)
        public function hasEventListener(type:String):Boolean{
            return dispatcher.hasEventListener(type);
        }

        /**
         *  @private
         */
		protected function dispatchChange(eventName:String):void{
			dispatchEvent(new org.apache.royale.events.Event(eventName));
        }

		private var _strand:IStrand;

        /**
         *  @copy org.apache.royale.core.IBead#strand
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function set strand(value:IStrand):void
		{
			_strand = value;
		}

		private var _dataProvider:IArrayList;

		[Bindable("dataProviderChanged")]
        /**
         *  @copy org.apache.royale.core.ISelectionModel#dataProvider
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get dataProvider():Object
		{
			return _dataProvider;
		}

        /**
         *  @private
         */
		public function set dataProvider(value:Object):void
		{
            if (value == _dataProvider) return;

            _dataProvider = value as IArrayList;
			if(!_dataProvider || _selectedIndex >= _dataProvider.length)
				_selectedIndex = -1;
            
			_selectedItem = _selectedIndex == -1 ? null : _dataProvider.getItemAt(_selectedIndex);
			
			dispatchChange("dataProviderChanged");
		}

		private var _selectedIndex:int = -1;
		private var _rollOverIndex:int = -1;
		private var _labelField:String = null;

        /**
         *  @copy org.apache.royale.core.ISelectionModel#labelField
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get labelField():String
		{
			return _labelField;
		}

        /**
         *  @private
         */
		public function set labelField(value:String):void
		{
			if (value != _labelField) {
				_labelField = value;
				dispatchChange("labelFieldChanged");
			}
		}

        /**
         *  @copy org.apache.royale.core.ISelectionModel#selectedIndex
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}

        /**
         *  @private
         */
		public function set selectedIndex(value:int):void
		{
            if (value == _selectedIndex) return;

			_selectedIndex = value;
			_selectedItem = (value == -1 || _dataProvider == null) ? null : (value < _dataProvider.length) ? _dataProvider.getItemAt(value) : null;
			dispatchChange("selectionChanged");
		}

        /**
         *  @copy org.apache.royale.core.IRollOverModel#rollOverIndex
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get rollOverIndex():int
		{
			return _rollOverIndex;
		}

        /**
         *  @private
         */
		public function set rollOverIndex(value:int):void
		{
			if (value != _rollOverIndex) {
				_rollOverIndex = value;
				dispatchChange("rollOverIndexChanged");
			}
		}

		private var _selectedItem:Object;

        /**
         *  @copy org.apache.royale.core.ISelectionModel#selectedItem
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get selectedItem():Object
		{
			return _selectedItem;
		}

        /**
         *  @private
         */
		public function set selectedItem(value:Object):void
		{
            if (value == _selectedItem) return;

			_selectedItem = value;
			var n:int = _dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (_dataProvider.getItemAt(i) == value)
				{
					_selectedIndex = i;
					break;
				}
			}
			dispatchChange("selectionChanged");
		}

		private var _selectedString:String;

        /**
         *  An alternative to selectedItem for strongly typing the
         *  the selectedItem if the Array is an Array of Strings.
         *
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.9.4
         */
		public function get selectedString():String
		{
			return String(_selectedItem);
		}

        /**
         *  @private
         */
		public function set selectedString(value:String):void
		{
			_selectedString = value;
			var n:int = _dataProvider.length;
			for (var i:int = 0; i < n; i++)
			{
				if (String(_dataProvider.getItemAt(i)) == value)
				{
					_selectedIndex = i;
					break;
				}
			}
			dispatchChange("selectionChanged");
		}
	}
}
