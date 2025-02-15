---
layout: post
title: How to legally destroy a scam website
subtitle: "Striking the Hydra's heart"
date: "2024-09-22"
#published: false
---

## Introduction

<img src="../images/0001-01-31/russian_house.png" class="image fit" alt="Russian House"/>
_Screenshot I took from Google Maps of alleged Russian scammer's house. Address omitted._

By the end of this you will understand what your target would be, what information to gather, how to turn major tech companies into your allies and most importantly, who you should report it to in order to shutdown the site. 

WARNING: If you don't know what you are doing, best read the whole blog, thank you.

Long ago my details were taken from a data breach and sold online. This included my DOB, address, email and full name. Since then I have had random scammers phone me by my real name to help build trust. 

These types of targeted scams can make building trust with the victim easier as your name and details are not something you give out to everyone. 

They can also feel more personal when you already know you're been scammed. Just knowing that your identity is no longer your own, is very unpleasant!

But you can legally take down the site and report the phishing email used. 

This blog was inspired by the Darknet Daries episode [Magecart](https://darknetdiaries.com/episode/52/) with interviewee Yonathan Klijnsma and Youtube video by [ThioJoe](https://youtu.be/0fIUiv9-UFk)

## Step 1: Find out what we need to target (DO NOT make this personal!)

_<img src="../images/0001-01-31/medium_1983_1462__0006_.jpg" class="image fit" alt="Computer bombsight type T1, mechanical analogue device, by A C Spark Plug Division"/>
Photo by <a href="https://collection.sciencemuseumgroup.org.uk/objects/co62556/aircraft-bomb-aiming-mechanical-computer">The Science Museum Group Collection</a> of a computer bombsight type T1<a href="https://collection.sciencemuseumgroup.org.uk/objects/co62556/aircraft-bomb-aiming-mechanical-computer">
</a>_

The domain name is like the central island of the scammer's website. 

We could say the website hosting provider builds and leases a bridge to the scammer's proverbial island to allow people to visit it and that the website could be the structures on top of that island.

Informing the scammer's web host provider that the website is hosted for illegal purposes can result in either a refusal or silence as the company will continue to make money. 

Others are more responsive. But even then it would be like destroying the bridge leading to the scammer's island. 

We could anomalously hack the site in various ways and set up a botnet to route a DDOS attack through insecure computers that unwitting people own. But if they were discovered by the scammer then they can be at risk of retaliation.

It is not unheard of for even cyber security professionals to mistakenly perform a simulated attack on the wrong target and get in trouble with an unrelated entity.

We could wipe out all the infrastructure on the island through the hack. Even if we erased the website, it could have been backed up elsewhere. Their base of operations can always later be rebuilt and quite easily if they have a backup.

Then there is the domain name registrar. We could imagine they own the island which the scammer rents. 

If we can convince the registrar that the domain name is being used for illegal purposes, then it can be enough to evict the scammer from the proverbial island. 

Once the domain name is taken offline, the scammer will need to find a new registrar or change their contact and company name details to find a suitable domain name, and may have to even tailor the whole website to that domain name.

It's just more stress for them to recover from which makes it the best target. 

**Whatever you do though, do not taunt the scammer from your own email or phone number. These are criminals, some of which are more powerful then their government. If you make it personal, they will make it personal.**

You are best blocking them ASAP if they are in contact with you, now.

## Step 2: Gather information about the target

<img src="../images/0001-01-31/drone-flying-over-road.jpg" class="image fit" alt="A drone flying over road with a car behind it."/> 

_Photo by <a href="https://www.shopify.com/stock-photos/@matthew_henry?utm_campaign=photo_credit&amp;utm_content=Browse+Free+HD+Images+of+Drone+View+Of+Car+Driving+Through+Forest&amp;utm_medium=referral&amp;utm_source=credit">Matthew Henry</a> from <a href="https://www.shopify.com/stock-photos/api-nature?utm_campaign=photo_credit&amp;utm_content=Browse+Free+HD+Images+of+Drone+View+Of+Car+Driving+Through+Forest&amp;utm_medium=referral&amp;utm_source=credit">Burst</a>_

Ensure you only open the scam website in a safe environment like a Virtual Machine with absolutely nothing personal on inside. 

If we can see evidence of a phishing scam on their site then we want to grab meta data, find out who hosts the site and who owns the domain. 

I once saw a russian web hosting company hosting a scam website who claimed to be an American company. The names and faces of their 6 employees could not be found on Linked In. Likely generated with AI. 

Some web hosting companies are a favorite among criminals who allow them to act with impunity, so if you are unsuccessful with taking down the domain, you will want to contact these guys as a last resort. 

You can go to websites that use the WHOIS internet protocol such as [https://who.is/whois/](https://who.is/whois/) and enter the domain there.

Look at the **Registrar Info** shown in the image below.

You will notice the domain is owned by [publicdomainregistry.com](https://publicdomainregistry.com/process-for-handling-abuse/) who I have provided an abuse response link for. You can select the Domain Abuse section and then select the Phishing "Get Started" button if you were dealing with a phishing scam for example.

Sometimes the domain registrar does not have a "report abuse" form. In that case if you go to [https://lookup.icann.org/en/lookup](https://lookup.icann.org/en/lookup) and type the domain, you should be able to see the abuse contact email under the Registrar Information heading. 

Back to the who.is site if you check the **Important Dates** section of the image, that can be a clear indicator that the scammer hasn't been in business long, as it was used in 2024/8/23.

Look at the **Name Servers** and notice most are within Russia. And if you find the geo coordinates of the ip address, it will lead to a house in Russia as shown in the title image. For all I know, the scammer may have used a VPN. So this may be the house of some other person. 

But if this is where the scammer lives, the house's horrid state shows that the scammer themselves may be struggling financially and have turned to crime to survive. 

Again this is why you need to avoid dealing with the scammer directly. A struggling dog backed into a corner can still be very dangerous. Especially if they have your details already.

<img src="../images/0001-01-31/Screenshot 2024-09-23 210607.png" class="image fit" alt="Image of who.is meta data."/>

## Step 3: Inform antivirus sites of your discovery

_<img src="../images/0001-01-31/mysterious-keyhole-light.jpg" class="image fit" alt="Salter, D. (2018). Mysterious Keyhole Light"/>
Photo by <a href="https://www.shopify.com/stock-photos/@saltyshots">Dave Salter</a> on <a href="https://www.shopify.com/stock-photos">Burst</a>_

You can use [my template](https://gist.github.com/LayersOfAbstraction/aabca490d4cd60f3dfbbadb32690aac6) for this if preferred. Make it as detailed as needed, you can always trim some details in a tailored copy if there are limits. 

Sometimes the registrar's email filters may pick up on the scam domain and throw your email to their junk folder so you may want to write the domain as https://en.wikipedia[.org]/wiki/WHOIS instead of [https://en.wikipedia.org/wiki/WHOIS](https://en.wikipedia.org/wiki/WHOIS) 

Before we try to take the domain down, we want to already try to alert the trusted anti-virus companies so the registrar has more of a reason to take the domain offline. 

Contact the antivirus sites or internet browser companies first. I have added a list from credited sources.   

Report to as many as possible. There are likely more that could be included. Try at least 5. _You don't have to do them all!_ If it helps the first 2 are the most important as Google and Microsoft will block the site from their internet browsers.

* [Google SafeBrowsing](https://safebrowsing.google.com/safebrowsing/report_phish/)
* [Microsoft](https://www.microsoft.com/en-us/wdsi/support/report-unsafe-site)
* [Virus Total](https://www.virustotal.com/gui/home/upload)
* [Palo Alto Networks](https://urlfiltering.paloaltonetworks.com/)
* [McAfee](https://sitelookup.mcafee.com/)
* [Symantec](https://sitereview.symantec.com/#/) 
* [Kaspersky](https://opentip.kaspersky.com/) 
* [Cisco Talos](https://talosintelligence.com/reputation_center) 
* [Total AV](https://www.totalav.com/submit-file)
* [Fortiguard](https://www.fortiguard.com/webfilter) 
* [BrightCloud](https://www.brightcloud.com/tools/url-ip-lookup.php)
* [CRDF](https://threatcenter.crdf.fr/submit_url.html)
* [Netcraft](https://report.netcraft.com/report) 
* [ESET](https://phishing.eset.com/en-us/report)
* [Trend Micro](https://global.sitesafety.trendmicro.com/index.php)
* [BitDefender](https://www.bitdefender.com/consumer/support/answer/29358/)
* [Spam404](https://www.spam404.com/report.html) 


## Step 4: Report the domain to the domain name registrar 

I cannot provide specific advice for how to report to each registrar but if you have a email from the scammer, check if you need to include email meta data like the header. Be sure not to click any links in the scam email unless you know how to test them in a secure sandbox. If the registrar does want the headers, you can check how to provide them as shown in the 3 most commonly used email clients of which you may be using. 

[Apple Mail](https://support.apple.com/en-au/guide/mail/mlhlp1089/mac#:~:text=Go%20to%20the%20Mail%20app,View%20%3E%20Message%20%3E%20Default%20Headers.)

[Gmail](https://support.google.com/mail/answer/29436?hl=en)

[Outlook](https://support.microsoft.com/en-au/office/view-internet-message-headers-in-outlook-cd039382-dc6e-4264-ac74-c048563d212c)

After reporting, it will be a waiting game. It took almost two weeks to get the scammer domain taken offline for me so I wish you the best of luck! Thanks for reading!

I hope you are able to achieve the same success in taking down these criminal domains as I did.

## REFERENCES:

Salter, D. (2018). Mysterious Keyhole Light. [online] Burst. Available at: https://www.shopify.com/stock-photos/photos/mysterious-keyhole-light [Accessed 22 Sep. 2024].

Stone, J. (2016). Russian web hosting service a favorite among cybercriminals. [online] The Christian Science Monitor. Available at: https://www.csmonitor.com/World/Passcode/2016/0803/Russian-web-hosting-service-a-favorite-among-cybercriminals [Accessed 22 Sep. 2024].

darknetdiaries.com. (n.d.). Magecart – Darknet Diaries. [online] Available at: https://darknetdiaries.com/episode/52/ [Accessed 22 Sep. 2024].

‌Henry, M. (2018). Drone Flying Over Road. [online] Burst. Available at: https://www.shopify.com/stock-photos/photos/drone-flying-over-road?c=drone [Accessed 23 Sep. 2024].

ThioJoe (2024). - YouTube. [online] Available at: https://youtu.be/0fIUiv9-UFk [Accessed 24 Sep. 2024].