---
layout: static
title: "Contents"
date: 2014-06-24
permalink: contents.html
description: |
  Contents of the entire blog, in chronological order; the page
  is generated automatically and contains a complete list
  of all articles published in this blog
keywords:
  - blog
  - contents
  - software development blog
  - tarun jangra blog
  - tarunjangra blog contents
  - articles about software development
  - articles about programming
exclude_from_search: true
script: |
  $(
    function() {
      total = 0;
      $('.comment-count:last-child').bind(
        'DOMSubtreeModified',
        function() {
          var m = /(\d+ ).*/.exec($(this).html());
          if (m) {
            total += m[1];
          }
        }
      )
      $('#total_comments').html(
        ' (' + total + ' comments total)'
      );
    }
  );
---

All tags (alphabetic order):

{{ site.tags | tag_cloud }}

Intensity of writing:

{% figure /stats.svg 700 %}

This is a full list of blogs published: <span id="total_comments"></span>:

{{ site.posts | tagged_list }}

