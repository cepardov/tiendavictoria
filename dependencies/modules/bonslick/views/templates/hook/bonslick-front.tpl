{*
 * 2015-2019 Bonpresta
 *
 * Bonpresta Awesome Image Slider
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade the module to newer
 * versions in the future.
 *
 *  @author    Bonpresta
 *  @copyright 2015-2019 Bonpresta
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*}

{if isset($items) && $items}
    <div class="clearfix"></div>
    <section id="bonslick" data-animation="fadeInUp" class="revealOnScroll animated fadeInUp">
        <ul class="bonslick-slider">
            {foreach from=$items item=item name=item}
			{if $item.type == 'image'}
                <li>
                    <a class="link-bonslick" href="{$item.url|escape:'htmlall':'UTF-8'}">
                        {if isset($item.image) && $item.image}
                            <img class="img-responsive" src="{$image_baseurl|escape:'htmlall':'UTF-8'}{$item.image|escape:'htmlall':'UTF-8'}" alt="{$item.title|escape:'htmlall':'UTF-8'}" />
                        {/if}
                        <section class="box-bonslick">
                            {if isset($item.description) && $item.description}
                                <div class="container">
                                    <div class="bonslick-caption col-xs-6 col-sm-6">
                                        {$item.description nofilter}
                                    </div>
                                </div>
                            {/if}
                        </section>
                    </a>
                </li>
				{else}
					<li>
						<div id="video-container">
							<a class="link-bonslick" href="{$item.url|escape:'htmlall':'UTF-8'}">
								<video id="video-element" class="bonslick-video" loop="loop">
									<source src="{$image_baseurl|escape:'htmlall':'UTF-8'}{$item.image|escape:'htmlall':'UTF-8'}" type="video/mp4">
								</video>
								<section class="box-bonslick">
									{if isset($item.description) && $item.description}
										<div class="container">
											<div class="bonslick-caption col-xs-6 col-sm-6">
												{$item.description nofilter}
											</div>
										</div>
									{/if}
								</section>
							</a>
							<div id="controls">
								<button id='btnPlayPause' class='play' accesskey="P" onclick='playPauseVideo();'></button>
								<button id='btnMute' class='mute'  onclick='muteVolume();'></button>
							</div>
						</div>
					</li>
				{/if}
            {/foreach}
			</ul>
			<script>
                        var player = document.getElementById('video-element');
                        var btnPlayPause = document.getElementById('btnPlayPause');
                        var btnMute = document.getElementById('btnMute');

                        if(player != null) {
                            playVideo ();

                        }
                        
                        function playVideo () {
                            player.addEventListener('play', function () {
                                changeButtonType(btnPlayPause, 'pause');
                            }, false);

                            player.addEventListener('pause', function () {
                                changeButtonType(btnPlayPause, 'play');
                            }, false);


                            player.addEventListener('ended', function () {
                                this.pause();
                            }, false);
                        }
                        function playPauseVideo() {
                            if (player.paused || player.ended) {
                                changeButtonType(btnPlayPause, 'pause');
                                player.play();
                            } else {
                                changeButtonType(btnPlayPause, 'play');
                                player.pause();
                            }
                        }

                        function stopVideo() {
                            player.pause();
                            if (player.currentTime) player.currentTime = 0;
                        }

                        function muteVolume() {
                            if (player.muted) {
                                // Change the button to a mute button
                                changeButtonType(btnMute, 'mute');
                                player.muted = false;
                            } else {
                                // Change the button to an unmute button
                                changeButtonType(btnMute, 'unmute');
                                player.muted = true;
                            }
                        }

                        function changeButtonType(btn, value) {
                            btn.innerHTML = value;
                            btn.className = value;
                        }
                    </script>
    </section>
{/if}
