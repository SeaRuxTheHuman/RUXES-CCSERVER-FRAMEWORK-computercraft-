# RUXES-CCSERVER-FRAMEWORK-computercraft-
<b>a framework I made for computercraft in-game servers.</b>

its based on a shitty little packet format I created. it consits
of a string thats split up with some code into a table. why I did
it this way I have no idea.

<u>the string format is as follows;</u>

<b>##TARGET;SENDER##<TYPE;METHOD;SUB_DATA></b>

this consits of two halfs, the parties half (the sender and the reciever) and the
core packet half, the parties section is defined between the '##' and the core
packed beteen the '<>' with all data split with the splitter ';'

<b>full packet breakdown</b>:

<ul>

<li>PARTIES HALF: TARGET - The indended target of the message</li>

<li>PARTIES HALF: SENDER - The sender of the message (duh.)</li>

<li>PACKET HALF: TYPE - the type of message being sent, thare are 5 types; OPEN, DIRECT, REQUEST, RESPONSE & STREAM.</li>

<li>PACKET HALF: METHOD - the method of the type, these are developer defined and are not static, thare is a shitty example function for the DIRECT message type that slowPrints 'Hello World'</li>

<li>PACKET HALF: SUB_DATA - any aditonal data, can be split up with the ';' splitter and it will be a seperate table entry, thare is no real limit to this beside the max length of the string if any (I dont belive it exists though)</li>
</ul>

<b>things id like to add: </b>
<ul>
 <li>the ability to load methods from files or something</li>
 <li>coroutine support for cooler shit</li>
 <li>a set of basic pre-set methods for streams and responses</li>
 <li>a practical apllication for this shit I wasted way to much of my time on</li>
</ul>



