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

package mx.controls.beads.controllers
{
	import mx.collections.XMLListCollection;
	
	import org.apache.royale.html.beads.controllers.CascadingMenuSelectionMouseController;
	import org.apache.royale.html.beads.models.CascadingMenuModel;

/**
 *  The CascadingMenuSelectionMouseController is the default controller for emulation cascading menu
 *
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */

	public class CascadingMenuSelectionMouseController extends org.apache.royale.html.beads.controllers.CascadingMenuSelectionMouseController
	{

		override protected function getSubMenuDataProvider(node:Object, model:CascadingMenuModel):Object
		{
			if (!(node is XML))
			{
				return super.getSubMenuDataProvider(node, model)
			}
			return new XMLListCollection((node as XML).children());
		}
		
		override protected function getHasMenu(node:Object, model:CascadingMenuModel):Boolean
		{
			if (!(node is XML))
			{
				return super.getHasMenu(node, model)
			}
			return (node as XML).children().length() > 0;
		}
	}

}