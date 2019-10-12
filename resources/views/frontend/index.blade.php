@extends('frontend.layouts.master')
@section('title', 'Home')
@section('content')
    <div class="container m-top-60">
        <div class="row">
            <div class="text-center">
                <img src="{{ asset('assets/images/logo/default.png') }}" width="20%"/>
                <h1>Laravel Boilerplate</h1>
            </div>
        </div>
        <!--=== Latest News Start ===---->
            @include('frontend.layouts.latest_news')
        <!--=== Latest News Start ===---->
    </div>
@endsection