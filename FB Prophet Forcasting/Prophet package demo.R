library(wikipediatrend)
library(dplyr)
tom_brady=wp_trend(page="Tom_Brady",from='2013-01-02',to='2016-01-01')

# removing zero's in count variable since that is actuall NA's

tom_brady=filter(tom_brady,count!=0)
qplot(date,count,data=tom_brady)
tom_brady$Log.count=log(tom_brady$count)


library(prophet)
#prophet needs column ds (date) and y the dependent variable
df=data.frame(ds=tom_brady$date,y=tom_brady$Log.count)
m=prophet(df)

#creating future data
future=make_future_dataframe(m,365)
tail(future)


forcast=predict(m,future)
plot(m,forcast)
prophet_plot_components(m,forcast)
