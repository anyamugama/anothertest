--drop table [dbo].[Attrition Graph]
--select count(*) from  [dbo].[Attrition Graph] --
select count(*) from [dbo].[Status Table]
select count(*) from [dbo].[Payment query]
select count(*) from [dbo].[Pledge query]
select count(*) from [dbo].[Sustainer Query]
select count(*) from [dbo].[Account Query]
--drop table [dbo].[Payment query]
--drop table [dbo].[Status Table]
--drop table [dbo].[Attrition Graph1]
--drop table [dbo].[Pledge query]
--drop table #UKSustainers
select 
    distinct
    st.ID,
    st.[Marketing Division],
	st.Channel,
	st.[Sub Channel],
	st.[Donor Country],
	st.PaymentMethodSummary,
	st.Pledge_Range as MonthlyGiftRange,
	pay.DepositSite,
    st.[Active/Lost/Lapsing], 
	st.[Status],
	pay.Month_Established,
	pld.Date_Established,
	pay.CloseDate as DateOfPayment,
	pay.Payment as PaymentNumber, --this skips numbers where payments were skipped, shows when there are payment skips
	pay.Months_Elapsed_Since_Pledge, --to cater for time on file??
	st.[Months Prior],
		sum(st.[Monthly Pledge]) as MonthlyPledge,
	pld.CampaignType,
	pld.Market_Source,
	aq.Age as DonorAge,
	count(distinct st.ID) as #Sustainers
into #UKSustainersDataWithPayments
from [dbo].[Status Table] st
left join [dbo].[Payment query] pay
on st.ID = pay.ID
 left join [dbo].[Pledge query] pld
 on st.ID = pld.Donors
 left join [dbo].[Account Query] aq
 on pay.ID = aq.AccountSFID
where st.[Marketing Division]= 'UK Marketing'
--and Month_Established is not null
group by st.[Marketing Division],
    st.ID,
	st.Channel,
	st.[Sub Channel],
		st.[Donor Country],
	st.PaymentMethodSummary,
	st.Pledge_Range,
	pay.DepositSite,
    st.[Active/Lost/Lapsing], 
	st.[Status],
	st.[Months Prior],
	pay.Month_Established,
     pld.Date_Established,
	pay.CloseDate,
	pay.Payment,--this skips numbers where payments were skipped, shows when there are payment skips
	pay.Months_Elapsed_Since_Pledge,	
	st.[Months Prior],
	pld.CampaignType,
	pld.Market_Source,
	aq.Age
--order by st.ID,st.[Months Prior] --pay.CloseDate, --4931 rows

select * from [dbo].[Payment query] 
where MarketingDivision = 'UK Marketing' --ID = '0063100000etRhVAAU'
order by ID


select top 5 * from [dbo].[Pledge query] 
where Donors = '0063r000019a01ZAAQ'

select top 5 * from [dbo].[Status Table] 
where ID = '0063r000019a01ZAAQ'

select * from [dbo].[Sustainer Query]

-----------------------------
select * from #UKSustainersDataWithPayments 
order by ID, DateOfPayment
order by ID, DateOfPayment --, [Months Prior]
select * into #UKSustainersDataWithPayments 

select * [except [Month Prior]] from #UKSustainersDataWithPayments
order by ID, DateOfPayment, [Months Prior]

