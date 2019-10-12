@extends('backend.layouts.master')
@section('title', 'Dashboard')
@section('content')
    <div class="row">
        <div class="col-md-12">
            <div class="box box-success">
                <div class="box-header with-border">
                    <p class="panel-title"> Admin's Profile</p>
                </div>
                <div class="box-body">
                    @if (session('status'))
                        <div class="alert alert-success">
                            {{ session('status') }}
                        </div>
                    @endif
                    <div class="row">
                        <div class="col-md-9 col-sm-12 table-responsive">
                            <table id="view_details" class="table table-bordered table-hover">
                                <tbody>
                                <tr>
                                    <td class="subject"> Name</td>
                                    <td> :</td>
                                    <td> {{ $user->name }} </td>
                                </tr>
                                <tr>
                                    <td class="subject"> Email</td>
                                    <td> :</td>
                                    <td> {{ $user->email }} </td>
                                </tr>
                                <tr>
                                    <td class="subject"> Status</td>
                                    <td> :</td>
                                    <td> @php $status = $user->status ? '<span class="label label-success">Active</span>' : '<span class="label label-danger">Inactive</span>' ;  @endphp {!! $status !!}   </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
