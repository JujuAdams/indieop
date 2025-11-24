<h1 align="center">indieop 1.0.0</h1>

<p align="center"><a href="https://indieop.com/">indieop</a> implementation for GameMaker</p>

<p align="center"><a href="https://github.com/JujuAdams/indieop/releases/">Download the .yymps</a></p>

&nbsp;

1. Set up an account on [indieop](https://indieop.com/). The [free plan](https://indieop.com/pricing) is (at the time of writing) limited to 1 game, 1 team member, and 50 form submissions per month so bear that in mind.
2. Set up a game [in the backend](https://indieop.com/dashboard) and find your API key.
3. Import the [.yymps](https://github.com/JujuAdams/indieop/releases) into your GameMaker project.
4. Open `__indieopConfig` and copy-paste your API key into the `INDIEOP_API_KEY` macro. Set `INDIEOP_DEBUG` to `true` to help with testing.
5. Create a form with `new indieopForm()` and add fields with the various field method (please see documentation in the script itself for an example).
6. Submit the form with the `.Submit()` method. Check your debug log for any error messages and resolve them as necessary.
7. Check that the form was submitted successfully by refreshing your dashboard. Submissions appear quickly in my experience.
8. Set `INDIEOP_DEBUG` to `false` to avoid future debug spam. Integrate form submission into your game's UI.

&nbsp;

You may also be interested in [Google Analytics](https://github.com/JujuAdams/GoogleAnalytics4) and [Unity Analytics](https://github.com/JujuAdams/unityanalytics) implementations for GameMaker. If you're looking for bug tracking specifically, [Snitch](https://github.com/JujuAdams/snitch) is worth a look too.
