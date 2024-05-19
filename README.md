# Weather

Some scripts to collect weather prediction xml from Environment Canda and parse it. I may use this some day for some DS project.

## Updates

Forecasts are updated hourly automatically with a github action and the updates are pushed to a b2 bucket. This repo used to get updated hourly, but it grew too big so it will no longer be updated. If you would like any files newer than what is in the repo please contact me.

This used to just pull forecasts for Toronto and those old forecasts are in `old_forecasts.tar.gz`. Now all cities are pulled and put in a folder corresponding to their province.

Be sure to push to the branch every 60days or github will disable the workflow.
