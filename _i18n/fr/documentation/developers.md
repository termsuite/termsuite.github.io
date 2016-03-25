
* TOC
{:toc}

### Construire TermSuite depuis les sources avec Git et Gradle

~~~
$ git clone git@github.com:termsuite/termsuite-core.git
$ cd termsuite-core
$ gradle jcasgen build
~~~
Le jar sera ainsi dans ./build/libs.

### Utiliser TermSuite comme une dépendance Maven

{% highlight xml %}

<dependency>
  <groupId>fr.univ-nantes.termsuite</groupId>
  <artifactId>termsuite-core</artifactId>
  <version>{{site.termsuite.version}}</version>
</dependency>

{% endhighlight %}
