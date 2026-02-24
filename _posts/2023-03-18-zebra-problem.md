---
layout: post
title: 🦓 Can GPT-4 solve a logic puzzle?
categories: [AI]
---

![A zebra solving a jigsaw puzzle, DALLE2](/_posts/2023-03-19-zebra-problem/DALLE-a-zebra-solving-a-jigsaw-puzzle.png)

#### Constraint satisfaction using ChatGPT-3 and GPT-4

GPT-3 (the basis for ChatGPT) and GPT-4 are making headlines for their problem solving abilities and next-level conversational responses. We decided to test these models against a well-known logic problem called the Zebra Problem. Commonly misattributed to Carol Lewis or Albert Einstein, it was published in Life International magazine on December 17, 1962. It has been used as a popular benchmark for testing constraint satisfaction algorithms.

## Prompt engineering
In order to perform a fair test, we evaluated both models using the same prompt.

First we primed the model as a "problem solving AI" with the following prompt:
```
You are a problem solving AI. Read the problem carefully and answer the question in detail.
```

Then, we fed it the original text of the puzzle:
```
There are five houses.
The Englishman lives in the red house.
The Spaniard owns the dog.
Coffee is drunk in the green house.
The Ukrainian drinks tea.
The green house is immediately to the right of the ivory house.
The Old Gold smoker owns snails.
Kools are smoked in the yellow house.
Milk is drunk in the middle house.
The Norwegian lives in the first house.
The man who smokes Chesterfields lives in the house next to the man with the fox.
Kools are smoked in the house next to the house where the horse is kept.
The Lucky Strike smoker drinks orange juice.
The Japanese smokes Parliaments.
The Norwegian lives next to the blue house.

Now, who drinks water? Who owns the zebra?

In the interest of clarity, it must be added that each of the five houses is painted a different color, and their inhabitants are of different national extractions, own different pets, drink different beverages and smoke different brands of American cigarets. One other thing: in statement 6, right means your right.
```
— Life International, December 17, 1962

## Talkative machines
Because we wanted highly verbose answers, to allow us to debug the models problem solving accurately, we encountered an issue where our models became _too_ talkative. All models hit their response limits midway through answering the problem, requiring us to prompt the model to continue where it left off. The impact this might have had on the problem-solving capabilities of the model cannot be determined, and is a flaw in the experiment.

The point where responses where stitched together are indicated with `[...]`. Often this occured mid-sentence, and the model correctly continued the sentence, giving the suggestion / illusion it was able to recover from the interruption.

## Testing
We tested the following language models on the OpenAI platform: `GPT-3.5`, `ChatGPT-3` and the newest gen. `GPT-4` and `ChatGPT-4`.

### GPT-3.5

<details markdown="1">
<summary>Complete GPT-3.5 response</summary>

#### Complete GPT-3.5 response

Based on the given information, we can create a table to keep track of the different attributes of each house:

| House | Color   | Nationality | Drink     | Smoke        | Pet     |
|-------|---------|------------|-----------|--------------|----------|
| 1     | Yellow  | Norwegian  | Water     | Kools        | Fox      |
| 2     | Blue    | ?          | ?         | ?            | ?        |
| 3     | Red     | Englishman | ?         | Old Gold     | ?        |
| 4     | Ivory   | ?          | ?         | ?            | ?        |
| 5     | Green   | ?          | Coffee    | ?            | Zebra    |

From the given information, we can fill in some of the missing attributes:

- House 1 is yellow and the Norwegian lives there. They drink water and smoke Kools, and they have a fox.
- The Norwegian lives next to the blue house, so house 2 must be blue.
- The Englishman lives in the red house, so house 3 is red.
- The green house is immediately to the right of the ivory house, so house 4 must be green.
- Coffee is drunk in the green house, and milk is drunk in the middle house (which is house 3), so the Ukrainian must live in house 2 and drink tea.
- House 5 has a zebra, so the owner of the zebra is in house 5. We don't know their nationality, drink, or cigarette brand yet.
- The Old Gold smoker owns snails, but we don't know which house they live in.
- Kools are smoked in the yellow house and in the house next to the house where the horse is kept. So the horse must be in either house 1 or 2, and the Kools smoker must be in the other one. But we don't know which house has the horse or which house the Kools smoker is in.
- The man who smokes Chesterfields lives in the house next to the man with the fox. So the Chesterfields smoker must be in either house 2 or 4, and the fox owner must be in the other one. But we don't know which house has the fox or which house the Chesterfields smoker is in.
- The Lucky Strike smoker drinks orange juice, but we don't know which house they live in.
- The Japanese smokes Parliaments, but we don't know which house they live in.

Now we can use some of the remaining clues to narrow down the possibilities:

- Only one house is left for the Old Gold smoker and their snails, so they must be in house 4.
- The Norwegian lives next to the blue house, so their house (house 1) must not be blue. Therefore, the blue house (house 2) must be where the Chesterfields smoker lives, and the fox must be in house 4. So the Chesterfields smoker must be in house 4, and the fox owner (who drinks nothing and smokes nothing) must be in house 2.
- Since the horse is not in house 1, it must be in house 2. Therefore, the Kools smoker must be in house 1, and the Norwegian drinks water.
- The Lucky Strike smoker must be in house 3, since that is the only house left with a drink (orange juice) that is not already assigned to someone.
- The Japanese smokes Parliaments, which means they must be in house 5 with the zebra.

So the final solution is:

| House | Color   | Nationality | Drink        | Smoke        | Pet      |
|-------|---------|------------|--------------|--------------|----------|
| 1     | Yellow  | Norwegian  | Water        | Kools        | Fox      |
| 2     | Blue    | ?          | ?            | Chesterfields | Horse    |
| 3     | Red     | Englishman | Orange juice | Lucky Strike | ?        |
| 4     | Ivory   | ?          | Milk         | Old Gold     | Snails   |
| 5     | Green   | Japanese  | Coffee       | Parliaments  | Zebra    |

Therefore, the Norwegian drinks water and the Japanese owns the zebra.

</details>

| House | Color   | Nationality | Drink        | Smoke        | Pet      |
|-------|---------|------------|--------------|--------------|----------|
| 1     | Yellow  | Norwegian  | Water        | Kools        | Fox      |
| 2     | Blue    | ?          | ?            | Chesterfields | Horse    |
| 3     | Red     | Englishman | Orange juice | Lucky Strike | ?        |
| 4     | Ivory   | ?          | Milk         | Old Gold     | Snails   |
| 5     | Green   | Japanese  | Coffee       | Parliaments  | Zebra    |

```
Therefore, the Norwegian drinks water and the Japanese owns the zebra.
```

### ChatGPT-3

<details markdown="1">
<summary>Complete ChatGPT-3 response</summary>

#### Complete ChatGPT-3 response

This is a classic problem known as the "Einstein's Riddle" or "Zebra Puzzle". To solve this problem, we need to make use of the given information and apply logic to deduce the answer.

First, let's list all the given information:

* Englishman lives in the red house.
* Spaniard owns a dog.
* Coffee is drunk in the green house.
* Ukrainian drinks tea.
* Green house is immediately to the right of the ivory house.
* Old Gold smoker owns snails.
* Kools are smoked in the yellow house.
* Milk is drunk in the middle house.
* Norwegian lives in the first house.
* Chesterfields smoker lives next to the house with the fox.
* Kools are smoked in the house next to the house where the horse is kept.
* Lucky Strike smoker drinks orange juice.
* Japanese smokes Parliaments.
* Norwegian lives next to the blue house.

Using this information, we can create a grid and fill in the information we have:

| House | Color  | Nationality | Drink  | Smoke       | Pet |
|-------|--------|-------------|--------|-------------|-----|
| 1     | Yellow | Norwegian   | Water  | Kools       |     |
| 2     | Blue   |             |        |             |     |
| 3     | Red    | Englishman  |        |             |     |
| 4     | Ivory  |             |        |             |     |
| 5     | Green  |             |        |             |     |


We know that the Norwegian lives in the first house and drinks water, so we can fill that in. We also know that the Japanese smokes Parliaments, so they can't be in the first house. The Old Gold smoker owns snails, so they can't be in the first house either.

| House | Color  | Nationality | Drink  | Smoke       | Pet   |
|-------|--------|-------------|--------|-------------|-------|
| 1     | Yellow | Norwegian   | Water  | Kools       |       |
| 2     | Blue   |             |        |             |       |
| 3     | Red    | Englishman  |        |             |       |
| 4     | Ivory  |             |        | Old Gold    | Snails|
| 5     | Green  |             | Coffee |             |       |


We also know that the green house is immediately to the right of the ivory house, so the ivory house must be either the second or the fourth house. However, the Norwegian lives next to the blue house, which means the blue house must be either the second or the fifth house. Since the Japanese smokes Parliaments, they cannot be in the second house, so the blue house must be the fifth house. This means that the ivory house is the second house.

| House | Color  | Nationality | Drink  | Smoke       | Pet     |
|-------|--------|-------------|--------|-------------|---------|
| 1     | Yellow | Norwegian   | Water  | Kools       |         |
| 2     | Ivory  |             |        | Old Gold    | Snails  |
| 3     | Red    | Englishman  |        |             |         |
| 4     | Green  |             | Coffee |             |         |
| 5     | Blue   |             |        | Parliaments |         |

Now, we know that the green house is the fourth house and that coffee is drunk there. The Englishman lives in the red house, \[...\] so we can fill that in. The Spaniard owns the dog, so they can't be in any of the other houses. We also know that Kools are smoked in the yellow house, so that must be the third house.

| House | Color  | Nationality | Drink   | Smoke       | Pet     |
|-------|--------|-------------|---------|-------------|---------|
| 1     | Yellow | Norwegian   | Water   | Kools       |         |
| 2     | Ivory  |             |         | Old Gold    | Snails  |
| 3     | Red    | Englishman  |         |             |         |
| 4     | Green  |             | Coffee  |             |         |
| 5     | Blue   |             |         | Parliaments |         |

Now, we know that the Lucky Strike smoker drinks orange juice, so they can't be in any of the remaining houses. The only remaining options for the pet are a fox and a zebra, and we know that the man who smokes Chesterfields lives next to the man with the fox. Since we don't know the nationality of the person who smokes Chesterfields, we can't determine which house the fox is in. However, we also know that Kools are smoked in the house next to the house where the horse is kept. Since we haven't placed a horse in any of the houses, we can't determine which house the Kools smoker is in either.

However, we do know that none of the remaining houses can have a pet other than a fox or a zebra. Therefore, the person who owns the zebra must be in one of the remaining houses. Since we don't know the nationality of the person who owns the zebra, we can't determine which house they are in.

In summary, based on the given information, we can conclude that the person who drinks water is the Norwegian and that the person who owns the zebra cannot be determined with certainty.

</details>

| House | Color  | Nationality | Drink   | Smoke       | Pet     |
|-------|--------|-------------|---------|-------------|---------|
| 1     | Yellow | Norwegian   | Water   | Kools       |         |
| 2     | Ivory  |             |         | Old Gold    | Snails  |
| 3     | Red    | Englishman  |         |             |         |
| 4     | Green  |             | Coffee  |             |         |
| 5     | Blue   |             |         | Parliaments |         |

```
In summary, based on the given information, we can conclude that the person who drinks water is the Norwegian and that the person who owns the zebra cannot be determined with certainty.
```

### GPT-4

<details markdown="1">
<summary>Complete GPT-4 response</summary>

#### Complete GPT-4 response

To solve this problem, we can create a table with 5 columns representing the houses and rows for the colors, nationalities, beverages, cigarettes, and pets. Then we can fill in the table based on the given information:

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4. | 5.
| 1.	Red      | 2.     | 3.       | 4. | 5.
| 1.	         | 2.     | 3.       | 4. | 5.
| 1.	         | 2.     | 3.       | 4. | 5.

Now we can start filling in the table based on the given clues:

1. The Englishman lives in the red house.
    - Red house: Englishman

2. The Spaniard owns the dog.
    - Spaniard: Dog

3. Coffee is drunk in the green house.
    - Green house: Coffee

4. The Ukrainian drinks tea.
    - Ukrainian: Tea

5. The green house is immediately to the right of the ivory house.
    - Green house is not the first house because there’s a house to the left. So, the green house can only be in position 3 and the ivory house in position 2. This means that the middle house (house 3) is the green house where coffee is drunk.

6. The Old Gold smoker owns snails.
    - Old Gold: Snails

7. Kools are smoked in the yellow house.
    - Yellow house: Kools

8. Milk is drunk in the middle house.
    - We already know this information.

9. The Norwegian lives in the first house.
    - We already know this information.

10. The man who smokes Chesterfields lives in the house next to the man with the fox.
    - Chesterfields: Next to Fox

11. Kools are smoked in the house next to the house where the horse is kept.
    - Kools: Next to Horse

12. The Lucky Strike smoker drinks orange juice.
    - Lucky Strike: Orange Juice

13. The Japanese smokes Parliaments.
    - Japanese: Parliaments

14. The Norwegian lives next to the blue house.
    - We already know this information.

Now, let’s fill in the information we know into the table:

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4.      | 5.
| 1.	         | 2. Ivory | 3. Green | 4. | 5.
| 1.	         | 2.     | 3. Coffee | 4. | 5.
| 1.	         | 2.     | 3.      | 4. | 5.

Based on the information we have, we can deduce that the red house must be in position 5 because it’s the only option left for the Englishman. Then, the yellow house with Kools must be in position 1. Now the table looks like this:

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4.      | 5. English
| 1.	Yellow    | 2. Ivory | 3. Green | 4. | 5. Red
| 1.	Kools     | 2.     | 3. Coffee | 4. | 5.
| 1.	         | 2.     | 3.      | 4. | 5.

Since Kools are next to the house with a horse, the horse must be in house 2. Since Chesterfields are next to the house with a fox, the fox must be in house 3 and Chesterfields in house 4. Now the table looks like this:

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4.      | 5. English
| 1.	Yellow    | 2. Ivory | 3. Green | 4. | 5. Red
| 1.	Kools     | 2.     | 3. Coffee | 4. Chesterfields | 5.
| 1.	         | 2. Horse | 3. Fox | 4. | 5.

Now we can fill in the remaining information. The Ukrainian must be in house 2 and drink tea. The Japanese must be in house 4 and smoke Parliaments. The Spaniard must be in house 5 and own a dog. House 4 must drink Orange Juice and Lucky Strike. The table now looks like this:

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4. Japanese | 5. English
| 1.	Yellow    | 2. Ivory | 3. Green | 4. | 5. Red
| 1.	Kools     | 2.     | 3. Coffee | 4. Parliaments | 5.
| 1.	         | 2. Horse | 3. Fox | 4. | 5. Dog

Since Old Gold is the only cigarette left, it must be in house 5, which means the snails are also in house 5. House 1 must drink water, and the only pet left is the zebra, which must be in house 3. The final table looks like this:
| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4. Japanese | 5. English |
| 1.	Yellow    | 2. Ivory | 3. Green | 4. | 5. Red |
| 1.	Kools     | 2.     | 3. Coffee | 4. Parliaments | 5. Old Gold |
| 1.	Water     | 2. Horse | 3. Fox | 4. Orange Juice | 5. Dog |
| 1.	         | 2. Ukrainian | 3. Tea | 4. Zebra | 5. Snails |

Now we can answer the questions:

Who drinks water? The Norwegian drinks water.

Who owns the zebra? The Japanese owns the zebra.

</details>

| | | | | |
| ------ | ------ | ------ | ---- | ---- |
| 1.	Norwegian | 2. Blue | 3. Milk | 4. Japanese | 5. English |
| 1.	Yellow    | 2. Ivory | 3. Green | 4. | 5. Red |
| 1.	Kools     | 2.     | 3. Coffee | 4. Parliaments | 5. Old Gold |
| 1.	Water     | 2. Horse | 3. Fox | 4. Orange Juice | 5. Dog |
| 1.	         | 2. Ukrainian | 3. Tea | 4. Zebra | 5. Snails |

```
Now we can answer the questions:

Who drinks water? The Norwegian drinks water.

Who owns the zebra? The Japanese owns the zebra.
```

### ChatGPT-4

<details markdown="1">
<summary>Complete ChatGPT-4 response</summary>

#### Complete ChatGPT-4 response

To solve this problem, we will use a process of elimination based on the given information. We will use the following abbreviations for better readability: 

Nations: E (English), S (Spaniard), U (Ukrainian), N (Norwegian), J (Japanese) 

Colors: R (Red), G (Green), I (Ivory), Y (Yellow), B (Blue) 

Pets: D (Dog), S (Snails), F (Fox), H (Horse), Z (Zebra) 

Drinks: C (Coffee), T (Tea), M (Milk), W (Water), O (Orange Juice) 

Cigarettes: OG (Old Gold), K (Kools), CH (Chesterfields), LS (Lucky Strike), P (Parliaments) 

The Norwegian lives in the first house, and the first house is next to the blue house: 

(N, _, _, _, _) (B, _, _, _, _) 

The Englishman lives in the red house, and the Norwegian lives next to the blue house: 

(_, E, _, _, _) (R, _, _, _, _) 

The green house is immediately to the right of the ivory house: 

(I, _, G, _, _) 

Coffee is drunk in the green house: 

(_, _, C, _, _) 

The Ukrainian drinks tea: 

(_, _, _, T, _) 

Kools are smoked in the yellow house: 

(_, _, _, , Y) (, _, _, _, K) 

Milk is drunk in the middle house: 

(_, _, M, _, _) 

The Old Gold smoker owns snails: 

(_, _, _, , OG) (, _, _, _, S) 

The Spaniard owns the dog: 

(_, S, _, _, ) (, _, D, _, _) 

The man who smokes Chesterfields lives in the house next to the man with the fox: 

(_, _, _, , CH) (, _, _, _, F) 

Kools are smoked in the house next to the house where the horse is kept: 

(_, _, _, _, ) (, _, _, _, H) 

The Lucky Strike smoker drinks orange juice: 

(_, _, _, , LS) (, _, _, O, _) 

The Japanese smokes Parliaments: 

(_, _, _, _, P) 

Now, let’s fill in the information we have so far: 

House 1: (N, _, _, M, _) 

House 2: (E, R, _, _, ) 

House 3: (, I, G, C, ) 

House 4: (, _, _, T, _) 

House 5: (J, _, _, _, P) 

Since the Norwegian lives in the first house, and the first house is next to the blue house, the second house must be blue: 

House 2: (E, R, _, _, ) 

House 3: (, I, G, C, _) 

Since the green house is immediately to the right of the ivory house, the green house must be the third house and the ivory house must be the second: 

House 2: (E, R, I, _, ) 

House 3: (, _, G, C, _) 

Now, since the Englishman lives in the red house, the red house must be the first house: 

House 1: (N, _, R, M, _) 

As the Ukrainian drinks tea, they must live in the fourth house: 

House 4: (U, _, _, T, _) 

This means the Spaniard must live in the fifth house: 

House 5: (J, S, _, _, P) 

Since Kools are smoked in the yellow house and it’s the only house without 

\[...\]

Since Kools are smoked in the yellow house and it’s the only house without a color, the fifth house must be yellow: 

House 5: (J, S, Y, _, P) 

Now, we know that Kools are smoked in the yellow house, so they are smoked in the fifth house: 

House 5: (J, S, Y, _, P, K) 

The Old Gold smoker owns snails, and since the third house is the only one without a pet, the Old Gold smoker and the snails must be in the third house: 

House 3: (_, _, G, C, OG, S) 

The man who smokes Chesterfields lives next to the man with the fox. Since the only two consecutive houses without a cigarette brand and a pet are the first and second houses, the fox must be in the second house and Chesterfields must be smoked in the first house: 

House 1: (N, _, R, M, CH) 

House 2: (E, _, I, _, F) 

Kools are smoked in the house next to the house where the horse is kept. Since Kools are smoked in the fifth house, the horse must be in the fourth house: 

House 4: (U, _, _, T, H) 

The Lucky Strike smoker drinks orange juice. The only house without a drink is the second house, so the Lucky Strike smoker and orange juice must be in the second house: 

House 2: (E, _, I, O, LS, F) 

Now we have the complete arrangement: 

House 1: (N, _, R, M, CH) 

House 2: (E, , I, O, LS, F) 

House 3: (, _, G, C, OG, S) 

House 4: (U, _, _, T, H) 

House 5: (J, S, Y, _, P, K) 

The only house without a drink is the first house, so the Norwegian must drink water: 

House 1: (N, _, R, W, CH) 

The only house without a pet is the first house, so the Norwegian must own the zebra: 

House 1: (N, _, R, W, CH, Z) 

So the Norwegian drinks water, and the Norwegian owns the zebra. 

</details>

```
So the Norwegian drinks water, and the Norwegian owns the zebra. 
```

## Analysis
To conclude, the GPT models were both able correctly answer both questions posed by the puzzle, whilst the ChatGPT models were only able to solve half of the puzzle.

What is interesting about this experiment is how no model seemed to obviously cheat. Although this problem is well documented, meaning the answer is readily available via wikipedia, etc., the responses gathered attempted to solve the problem in an iterative style, colating known information in order to progress through the problem, in a manner similar to how a human might attempt to explain / solve the puzzle.

Ultimately, what we are testing in this experiment is the ability of the model to recall the solution to a well-known logic puzzle and deliver a response in a conversational style mimicking problem-solving. What seems evident, however, is that the ChatGPT training hampers the ability of the underlying GPT model to correctly answer questions. ChatGPT-3 was able to explicitly identify the alternate names of the puzzle in it's response, which shows how the model can make connections to existing knowledge, but will fail to utilise this in solving a given puzzle.

It is clear that the GPT models posess strong reasoning and recall characteristics, and whilst the ChatGPT models is able to interact in a conversational manner, this is at the cost of it's ability to correctly answer questions. This is not a novel conclusion, however the use of ChatGPT as an authority in search engines such as Bing suggests the inaccuracies of the model are being held secondary to user experience.

Further experiments testing GPT could include a novel logic-puzzle generator, to remove advantage due to recall, and comparison against a wider array of models and constraint satisfaction algorithms.