package{
	import flash.display.MovieClip;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event; 
	import flash.media.SoundChannel;
	
	
	public class Main extends MovieClip{
		
		
		const gravity:Number = 1.5;            
		const dist_btw_obstacles:Number = 300; 
		var ob_speed:Number = 5;			   
		const jump_force:Number = 14;          
		
		
		var player:Player = new Player();	   
		var lastob:Obstacle = new Obstacle();  
		var obstacles:Array = new Array();     
		var yspeed:Number = 0;				   
		var score:Number = 0;
		//var  maxspeed:Number = 20;
		
		
		var my_sound: SoundId = new SoundId();
		var my_sound1: SoundId1 = new SoundId1();
		
		
		public function Main() {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,start);
			
			
		}
		
		
		
				
		
		function start(event:KeyboardEvent){
			gotoAndStop(3);
			init();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,start);
		}
		
		
		
		
		function Gameover(){
			gotoAndStop(8);
		
			removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
		
			stage.removeEventListener(KeyboardEvent.KEY_UP, key_up);
			
		}
		
		
		
		
		
		
		
		function init():void {
			player = new Player();
			
			lastob = new Obstacle();
			
			obstacles = new Array();
			
			yspeed = 0
			
			score = 0;
			
			ob_speed = 5;
			
						

			player.x = stage.stageWidth/2;
			player.y = stage.stageHeight/2;
			addChild(player);
			
			
			createObstacle();
			createObstacle();
			createObstacle();
			
			
			addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
            stage.addEventListener(KeyboardEvent.KEY_UP, key_up);
			stage.focus = stage;
			
			this.setChildIndex(scoretxt, numChildren -1);
		}
		
		private function key_up(event:KeyboardEvent){
			if(event.keyCode == Keyboard.SPACE){

				yspeed = -jump_force;
				var channel: SoundChannel = my_sound.play();
				
			}
			
		}
		
		function restart(){
			if(contains(player))
				removeChild(player);
				for(var i:int = 0; i < obstacles.length; ++i){
					if(contains(obstacles[i]) && obstacles[i] != null)
					removeChild(obstacles[i]);
					obstacles[i] = null;
				}
				obstacles.slice(0);
				var channel: SoundChannel = my_sound1.play();
				
		}
		
		function onEnterFrameHandler(event:Event){
			yspeed += gravity;
			player.y += yspeed;
			
	
			if(player.y + player.height/2 > stage.stageHeight){
				Gameover();
			}
			
			if(player.y - player.height/2 < 0){
				player.y = player.height/2;
			
				}
		
			for(var i:int = 0;i<obstacles.length;++i){
				updateObstacle(i);
			}
			scoretxt.text = String(score); 
			
		}
		
		function updateObstacle(i:int){
			var ob:Obstacle = obstacles[i];
			
			if(ob == null)
			return;
			ob.x -= ob_speed;
			
			
			if(ob.x < -ob.width){
				changeObstacle(ob);
			}
			
			if(ob.hitTestPoint(player.x + player.width/2,player.y + player.height/2,true)
			   || ob.hitTestPoint(player.x + player.width/2,player.y - player.height/2,true)
			   || ob.hitTestPoint(player.x - player.width/2,player.y + player.height/2,true)
			   || ob.hitTestPoint(player.x - player.width/2,player.y - player.height/2,true)){
				
				
			Gameover();
				
			var channel: SoundChannel = my_sound1.play();
			
			
			}
			
			if((player.x - player.width/2 > ob.x + ob.width/2) && !ob.covered){
				++score;
				ob.covered = true;
				++ob_speed;
			}
		}
		
		function changeObstacle(ob:Obstacle){
			ob.x = lastob.x + dist_btw_obstacles;
			
			ob.y = 100+Math.random()*(stage.stageHeight-200);
			
			lastob = ob;
			
			ob.covered = false;
			
			
			
		}
		
		function createObstacle(){
			var ob:Obstacle = new Obstacle();
			if(lastob.x == 0)
			ob.x = 800;
			else
				
			ob.x = lastob.x + dist_btw_obstacles;
			ob.y = 100+Math.random()*(stage.stageHeight-200);
			addChild(ob);
			
			obstacles.push(ob);
			lastob = ob;
			
		
}
		
		
	}
	
	
	}

