---
layout: post
title: AI for creative writing - a retrospective on Story Scribbler
categories:
  - AI
last-updated: 2026-01-10
---

<div style="width:100%; aspect-ratio:16/9;">
  <video 
    src="{{ site.baseurl }}/media/storyscribbler-retro/frontcover.mp4"
    style="width:100%; height:100%; object-fit:fit;"
    autoplay muted loop playsinline>
  </video>
</div>

[Story Scribbler](https://storyscribbler.com/home) was founded 2 years ago with a simple problem statement: can children with demand avoidance be engaged by AI powered content?

To understand the answer to this, I want to talk about Story Scribbler; who it's target audience is, how it works, and discuss why the product has been (by some metrics) life-changing for students, but lacks wide enough market fit to be profitable.

## Origins

The idea for Story Scribbler came about from discussing AI with a local school - the Dorset Center of Excellence / [Coombe House School](https://coombehouseschool.org.uk/) (CHS). CHS is specifically designed for young people from 5 to 19 with special educational needs. This means the challenges it faces are unique compared to traditional primary or secondary schools - for example, some older students will have lower level reading ability (for instance a year 12 student with a year 2 reading level), but still wish to engage with content appropriate for people their age.

What this can often result in is engagement with certain forms of media, like video games or movies, and a lack of interest in reading or writing.

So how do you engage students? You meet them at their interests. But how many books exist, for example, for teenagers but follow the phonics scheme? The short answer - little to none. This is where Story Scribbler steps into the picture.

## What makes this problem difficult?

To re-iterate, the problem here is two-fold:

1. Writing books is hard.
2. Writing books to a specific phonics level is even harder.

Try this exercise: come up with a short story (or even a few sentences) following these restrictions for phase 3 phonics:

<blockquote>Phase 3 phonics in the UK (part of the government’s Letters and Sounds programme) introduces children (usually in Reception, age 4–5) to the remaining letters of the alphabet and common digraphs/trigraphs such as ch, sh, th, ng, ai, ee, igh, oa, oo, ar, or, ur, ow, oi, ear, air, ure, er, so they can represent almost every sound in simple words. To write stories for this stage, use short sentences made from regular CVC/CVCC words and these Phase 3 digraphs (e.g. The goat in the rain had a red coat), avoiding more complex spellings and advanced grammar.
</blockquote>

It's suprisingly hard to pull off, consider this common fairy tale opener:

<blockquote>
  <span class="inaccessible">once</span> 
  <span class="inaccessible">upon</span> 
  a 
  <span class="inaccessible">time</span>, 
  in a land far, far 
  <span class="inaccessible">away</span>...
</blockquote>

Each of those highlighted terms are inaccessible to a person reading at a phase 3 phonics level.

## Can AI do any better?

A quick primer on how AI models like the one powering ChatGPT work - they don't understand words based on letters or phonics, they process _tokens_. A token is a unit of text - either single letters, whole words, or fragments of words. This matters since it makes it difficult for a model to definitively determine if a word matches the target phonics scheme.

For instance, our example above might be split up into this series of tokens:

<label style="font-family:monospace;font-size:12px;">
  <input type="checkbox" id="toggleIds" onchange="
    document.querySelectorAll('.word').forEach(e=>e.style.display=this.checked?'none':'inline');
    document.querySelectorAll('.id').forEach(e=>e.style.display=this.checked?'inline':'none');
  ">
  Show token IDs
</label>

<blockquote style="font-family:monospace; line-height:1.4; margin-top:8px;"><span style="background:#3b2f5a;color:#fff;"><span class="word">phon</span><span class="id" style="display:none;">73879</span></span><span style="background:#4f8f5b;color:#fff;"><span class="word">ics</span><span class="id" style="display:none;">1541</span></span><span style="background:#9c7a2b;color:#fff;"><span class="word"> are</span><span class="id" style="display:none;"> 553</span></span><span style="background:#a44a4a;color:#fff;"><span class="word"> absolutely</span><span class="id" style="display:none;"> 13907</span></span><span style="background:#2f6f7a;color:#fff;"><span class="word"> harder</span><span class="id" style="display:none;"> 27008</span></span><span style="background:#5a3b7a;color:#fff;"><span class="word"> than</span><span class="id" style="display:none;"> 1572</span></span><span style="background:#4f8f5b;color:#fff;"><span class="word"> it</span><span class="id" style="display:none;"> 480</span></span><span style="background:#9c7a2b;color:#fff;"><span class="word"> first</span><span class="id" style="display:none;"> 1577</span></span><span style="background:#a44a4a;color:#fff;"><span class="word"> appears</span><span class="id" style="display:none;"> 14518</span></span></blockquote>

If we talk about how large language models "percieve" text, this illustration shows it best. Instead of the building blocks of the latin alphabet, a LLM has a "vocabulary" of potentially hundreds of thousands of snippets of text. Some of these snippets are whole words, as we see above, whilst some might follow a common structure (e.g.: percieving `ordering` as `order` plus `ing`, since `ing` is a common extension for english words), others might be unintuitive to a person (as the structure of the vocabulary arises through a machine learning process, instead of human labelling).

Furthermore, if you click the toggle to show token IDs, you'll observe that the LLM doesn't even ingest words directly, but instead uses IDs correlating to parts of its vocabulary (this is because )

We can use this to observe how whitespace is treated - based on the highlighting, we can see that it is attached (often prepended) to words. As it happens, the LLM will assign different IDs to represent words with a space before them versus the word by itself. For example, `hello` has the ID `24912`, whereas <code>&nbsp;hello</code> has the ID `40617` - the model might treat the two inputs almost identically, but it does see them as separate "words" entirely.

This is a fundamental limitation to LLMs. Although you might not observe any noticeable difference between saying <code>&nbsp;hello</code> versus `hello` to a model, there is a unique difference, and this may confuse the model or create perturbations in its output, much like a butterfly effect, in certain scenarios.

Returning to the problem of phonics, it becomes clear that the model cannot understand the phonics of a word - so how could an LLM, with generally acceptable accuracy, identify the phonics scheme of a particular word, or write a short story that adheres to a phonics scheme?

The answer lies in the training data used to create the model. Models are essentially trained by wrote, meaning they're exposed to a vast amount of information via a process that through repetition distills emergent behaviours, such as the ability to seemingly reason and understand text, into the LLM.

In short, the model can accurately identify the phonics stage a word belongs to by either of the following mechanisms:

1. Because it has been shown prior information indicating the phonics stage of a word.
2. Because it is able to associate the whole word token with the series of letters (as individual tokens) and then follow phonics rules to identify potential phonemes.

Between these two mechanisms, a model can simulate "good enough" approximation, and only mis-identify words on rare occasions.

## More monkey than Shakespeare

So we've shown AI can understand phonics, but can it write good stories? Well that depends on your interpretation of what a good story is...

<div id="ss-book" style="margin:2.5em auto;max-width:480px;font-family:Georgia,'Times New Roman',serif;">
<div style="perspective:900px;perspective-origin:50% 0%;">
<div id="ss-leaf" style="
  position:relative;
  background:#f8f5ee;
  border-radius:0 5px 5px 0;
  border-top:1px solid #ddd5c0;
  border-right:1px solid #ddd5c0;
  border-bottom:1px solid #ddd5c0;
  border-left:5px solid #c8b99a;
  padding:2.4em 2.6em 3.6em 2.4em;
  min-height:300px;
  box-shadow:6px 8px 28px rgba(0,0,0,0.13),inset 0 0 0 1px rgba(255,255,255,0.6);
  transform-origin:left top;
  backface-visibility:hidden;
  -webkit-backface-visibility:hidden;
  will-change:transform;
  color:#2a2218;
  font-size:0.9em;
  line-height:1.85;
">
  <div id="ss-text" style="min-height:240px;white-space:pre-wrap;"></div>
  <div id="ss-pg" style="position:absolute;bottom:1.1em;left:0;right:0;text-align:center;font-size:0.7em;color:#b0a080;letter-spacing:0.08em;"></div>
</div>
</div>
<div style="display:flex;justify-content:space-between;align-items:center;margin-top:1.1em;">
<button id="ss-prev" class="pill" style="cursor:pointer;font-family:inherit;font-size:0.82em;">← Prev</button>
<span id="ss-count" style="color:var(--muted,#767676);font-size:0.78em;letter-spacing:0.04em;"></span>
<button id="ss-next" class="pill" style="cursor:pointer;font-family:inherit;font-size:0.82em;">Next →</button>
</div>
</div>

<script>
(function(){
var STORY=`The infant, Titus VII, wailed. Flay, tall and gaunt, watched the ancient naming. The air was thick, stale. He felt a pang. This boy… this boy was different. He saw a fire in the small eyes, a spark that Gormengast Station seemed determined to snuff out.\n\nYears spun by. Titus, a restless shadow, roamed the station's guts. Corridors twisted, machines groaned, and strange folk shuffled past. He saw a glint of metal, a flicker of light from a forgotten screen. He felt trapped. The rituals, the endless echoing chants, meant nothing.\n\nThen, he arrived. Steerpike. A rat in the walls, a whisper in the dark. He was thin, sharp-eyed, and hungry. He watched, he listened, he learned. He saw the Twins, Clarice and Cora, their faces tight with ambition. He fed them poison, sweet lies of power and control.\n\nThe Twins, buzzing with Steerpike's venom, swarmed around Titus. They pulled him into their games, their petty squabbles for scraps of influence. "Flay keeps you locked away, Titus," Clarice hissed. "He wants to control you!" Cora added, "We can help you be strong!" Titus recoiled. Their words were hollow, their eyes cold.\n\nOne day, lost in the station's depths, Titus stumbled upon a hidden chamber. Star charts glowed faintly on a dusty screen. Logs, filled with strange symbols, spoke of a mission, a purpose long lost. Escape. The word echoed in his mind. He traced the lines of the stars, a burning hope igniting within him.\n\n\n\nSteerpike's influence spread like a disease. A pipe burst, flooding a lower level. A vital generator sputtered and died. Chaos bloomed. Steerpike, always there, always helpful, rose through the ranks, a shadow puppet master pulling the strings.\n\nFlay saw the darkness in Steerpike. He confronted him in a narrow corridor, the air thick with tension. "You are a danger, Steerpike," Flay growled, his voice like grinding gears. "You poison the station." Steerpike smiled, a thin, cruel line. "The station is already poisoned, Flay. I am merely… expediting the process." Soon after, Flay was accused of sabotage, framed by Steerpike's lies.\n\nTitus, sickened by the station's rot, sought out Dr. Prunesquallor. The doctor, surrounded by bubbling beakers and strange instruments, listened with a knowing smile. "Escape, you say? A fascinating notion. The body craves freedom, just as the soul craves meaning. Look closely, Titus. The station whispers its secrets to those who listen." He hinted at a hidden passage, a forgotten escape route.\n\n\n\nSteerpike, now a powerful figure, controlled the station's resources. He hoarded fuel, manipulated rations, and tightened his grip on the inhabitants. He revealed his plan to a select few: to abandon Gormengast, taking its technology and leaving the rest to die.\n\nTitus, with a small band of loyal followers, including a Twin, Cora, who had seen Steerpike's true face, raced against time. They found the dormant escape pod, buried deep within the station's core. Titus studied the ancient star charts, his fingers tracing the faded lines.\n\nSteerpike confronted them near the pod. "You cannot leave, Titus," he hissed. "This technology is mine!" A desperate struggle ensued. Titus, fueled by a desperate hope, outsmarted Steerpike, trapping him in a collapsing section of the station.\n\nThe escape pod launched, tearing away from Gormengast. Titus looked back at the decaying station, a colossal, gothic ruin against the backdrop of a dying star. Relief washed over him, mixed with a profound sadness. Had he truly escaped? Or simply traded one prison for another? The pod's navigation system flickered, its destination uncertain. Titus stared into the vastness of space, his fate unknown.`;
var CHARS=400;
var pages=[];
var i=0;
while(i<STORY.length){
  var end=i+CHARS;
  if(end>=STORY.length){pages.push(STORY.slice(i));break;}
  var cut=STORY.lastIndexOf(' ',end);
  if(cut<=i)cut=end;
  pages.push(STORY.slice(i,cut));
  i=cut+1;
}
var idx=0;
var leaf=document.getElementById('ss-leaf');
var tx=document.getElementById('ss-text');
var pg=document.getElementById('ss-pg');
var ct=document.getElementById('ss-count');
var pb=document.getElementById('ss-prev');
var nb=document.getElementById('ss-next');
function render(){
  tx.textContent=pages[idx];
  pg.textContent='\u2014\u2002'+(idx+1)+'\u2002\u2014';
  ct.textContent=(idx+1)+' of '+pages.length;
  pb.style.opacity=idx===0?'0.3':'1';
  nb.style.opacity=idx===pages.length-1?'0.3':'1';
  pb.disabled=idx===0;
  nb.disabled=idx===pages.length-1;
}
function turn(d){
  var outTo=d>0?'rotateY(-100deg)':'rotateY(100deg)';
  var inFrom=d>0?'rotateY(100deg)':'rotateY(-100deg)';
  leaf.style.transition='transform 0.28s ease-in,box-shadow 0.28s';
  leaf.style.transform=outTo;
  leaf.style.boxShadow='1px 2px 4px rgba(0,0,0,0.05)';
  setTimeout(function(){
    idx+=d;render();
    leaf.style.transition='none';
    leaf.style.transform=inFrom;
    requestAnimationFrame(function(){requestAnimationFrame(function(){
      leaf.style.transition='transform 0.28s ease-out,box-shadow 0.28s';
      leaf.style.transform='rotateY(0deg)';
      leaf.style.boxShadow='6px 8px 28px rgba(0,0,0,0.13),inset 0 0 0 1px rgba(255,255,255,0.6)';
    });});
  },280);
}
nb.addEventListener('click',function(){if(idx<pages.length-1)turn(1);});
pb.addEventListener('click',function(){if(idx>0)turn(-1);});
render();
})();
</script>

Does this count as a good story? The answer is likely subjective based on your personal tastes, and even popular formula like ["save the cat"](https://en.wikipedia.org/wiki/Save_the_Cat!:_The_Last_Book_on_Screenwriting_You%27ll_Ever_Need), ["the seven basic plots"](https://en.wikipedia.org/wiki/The_Seven_Basic_Plots) or the ["Hero's journey"](https://en.wikipedia.org/wiki/Hero%27s_journey) don't guarantee appeal ([1](https://slate.com/culture/2013/07/hollywood-and-blake-snyders-screenwriting-book-save-the-cat.html)).

For Story Scribbler, the greatest challenge faced was the passivity of AI. Modern AI is designed to be palatable, which could be argued as making it excellent for writing stories appealing to the widest audience, but in reality results in stories that are simply uncontroversial or "bland". Forcing a model to exhibit behaviours outside of this out-of-the-box style proved to be an interesting challenge, and represented the most fragile part of the entire project.

Prompt engineering, when models like GPT-3 were released, required concerted effort to get decent performance, but the state of the art has advanced rapidly in the last few years to the point where the expectation for modern models is that prompt engineering is now about squeezing small performance gains. What we found developing the AI agent behind Story Scribbler, however, is that creative writing is still a frontier problem for models. Model upgrades or new features (e.g.: our phonics feature), could easily collapse the performance of the model and revert it back to passive voice, predictable, stories. We didn't discover a secret phrase for elucidating improved behaviour, but did find that a model could be coaxed into being more creative when creative (high tempurature) sub-agents were guided by lower temperature orchestration-agents, balancing creativity with necessary adherence to e.g.: JSON output or tool calling structures.

## Pilot programme and market-fit

Having developed this web-app, we set about sharing it with our beta-tester school. Coombe House School was an ideal first customer, and we found that students readily engaged with the app, creating stories whilst retaining a sense of ownership (as evidenced by anecdotes of sharing with teachers, other students, and carers). Furthermore, the work to create controversial stories paid off, as we found students (particularly the demographic of older students with lower level reading abilities) would often tie their stories back to their own interests, ranging from football to grim-dark fantasy (such as [Trench Crusade](https://www.trenchcrusade.com/)).

Emboldened by this success, we sought market fit among less-specialist schools, working with industry contacts to meet with schools with traditionally higher than average concentrations of students with learning or behavioural needs. Whilst we found interest amongst leadership and English leads, it was difficult to canvas schools at a sufficient volume to see conversion from our free trial to paid school memberships.

Overall, we'd consider this project to be a success - whilst finding profitability would have allowed Story Scribbler to continue offering services, the project vision wasn't predoominantly focussed on this (if it had been, compromises to the user experience or more gamified tactics could have been deployed, but these were avoided due to concerns about how it would affect the educational value of the tool).

## What's next

Although Story Scribbler may not be a unicorn venture, it does have a proved value to schools that adopt it - Coombe House School made the app an official part of it's curriculum for the 2025/26 academic year, a capstone achievement for the project. Due to it's tech-stack, the project is well-poised to transition into a native iOS or Android application, leveraging local large language models via device APIs, allowing for low-cost distribution. Additional options for the roadmap also include web-llm integration, however current state of the art produces a poor user experience - but once Chrome integration of Gemini Nano advances, this will be revisited ([1](https://developer.chrome.com/docs/ai/built-in), [2](https://developer.chrome.com/docs/ai/built-in-apis)).
